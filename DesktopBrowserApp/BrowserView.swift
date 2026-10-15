import SwiftUI
import WebKit

struct BrowserView: View {
    @Binding var showSettings: Bool
    @State private var urlString = "https://www.google.com"
    @State private var isLoading = false
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var showQuickMenu = false
    @State private var mousePosition: CGPoint = CGPoint(x: 200, y: 200)
    @State private var isPointerVisible = true
    
    @StateObject private var webViewStore = WebViewStore()
    
    var body: some View {
        VStack(spacing: 0) {
            // Address Bar
            HStack(spacing: 8) {
                Button(action: { webViewStore.goHome() }) {
                    Image(systemName: "house")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .padding(.leading, 8)
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                    TextField("URL eingeben", text: $urlString)
                        .textFieldStyle(PlainTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            webViewStore.loadURL(urlString)
                        }
                    Button(action: { /* Bookmark */ }) {
                        Image(systemName: "star")
                            .foregroundColor(.blue)
                    }
                    Button(action: { webViewStore.reload() }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(20)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            
            // WebView with pointer
            ZStack {
                WebView(webView: webViewStore.webView)
                    .onAppear {
                        webViewStore.loadURL(urlString)
                    }
                
                if isPointerVisible {
                    Image(systemName: "cursorarrow")
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(radius: 1)
                        .position(mousePosition)
                        .allowsHitTesting(false)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            
            // Bottom Toolbar
            HStack(spacing: 24) {
                Button(action: { webViewStore.goBack() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                .disabled(!canGoBack)
                .foregroundColor(canGoBack ? .blue : .gray)
                
                Button(action: { webViewStore.goForward() }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                .disabled(!canGoForward)
                .foregroundColor(canGoForward ? .blue : .gray)
                
                Button(action: { /* New tab */ }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                Button(action: { showQuickMenu = true }) {
                    ZStack {
                        Image(systemName: "square.grid.2x2")
                            .font(.title2)
                            .foregroundColor(.blue)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8, height: 8)
                            .offset(x: 12, y: -12)
                    }
                }
                
                Button(action: { showQuickMenu = true }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            
            // Trackpad
            TrackpadView(mousePosition: $mousePosition, webViewStore: webViewStore)
                .frame(height: 180)
                .padding(.horizontal)
                .padding(.bottom, 8)
        }
        .sheet(isPresented: $showQuickMenu) {
            QuickMenuView(showSettings: $showSettings)
        }
        .onReceive(webViewStore.$canGoBack) { canGoBack = $0 }
        .onReceive(webViewStore.$canGoForward) { canGoForward = $0 }
        .onReceive(webViewStore.$isLoading) { isLoading = $0 }
        .ignoresSafeArea(edges: .bottom)
    }
}

class WebViewStore: NSObject, ObservableObject {
    let webView: WKWebView
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var isLoading = false
    
    override init() {
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "Chrome/136.0.0.0 Safari/537.36"
        self.webView = WKWebView(frame: .zero, configuration: config)
        self.webView.customUserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
        super.init()
        webView.navigationDelegate = self
    }
    
    func loadURL(_ urlString: String) {
        var urlStr = urlString
        if !urlStr.hasPrefix("http") {
            urlStr = "https://" + urlStr
        }
        if let url = URL(string: urlStr) {
            webView.load(URLRequest(url: url))
        }
    }
    
    func goBack() { webView.goBack() }
    func goForward() { webView.goForward() }
    func reload() { webView.reload() }
    func goHome() { loadURL("https://www.google.com") }
}

extension WebViewStore: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isLoading = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
        canGoBack = webView.canGoBack
        canGoForward = webView.canGoForward
    }
}

struct WebView: UIViewRepresentable {
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    BrowserView(showSettings: .constant(false))
}
