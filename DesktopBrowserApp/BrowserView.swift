import SwiftUI
import WebKit

struct BrowserView: View {
    @State private var urlString = "https://www.google.com"
    @State private var isLoading = false
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var showQuickMenu = false
    @State private var mousePosition: CGPoint = .zero
    @State private var isPointerVisible = true
    
    @StateObject private var webViewStore = WebViewStore()
    
    var body: some View {
        VStack(spacing: 0) {
            // Address Bar
            HStack {
                Button(action: { webViewStore.goHome() }) {
                    Image(systemName: "house")
                        .font(.title2)
                }
                .padding(.leading)
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                    TextField("URL eingeben", text: $urlString)
                        .textFieldStyle(PlainTextFieldStyle())
                        .onSubmit {
                            webViewStore.loadURL(urlString)
                        }
                    Button(action: { /* Bookmark */ }) {
                        Image(systemName: "star")
                    }
                    Button(action: { webViewStore.reload() }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .padding(.horizontal)
            }
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            
            // WebView
            ZStack {
                WebView(webView: webViewStore.webView)
                    .onAppear {
                        webViewStore.loadURL(urlString)
                    }
                
                // Simulated mouse pointer
                if isPointerVisible {
                    Image(systemName: "cursorarrow")
                        .font(.title)
                        .foregroundColor(.black)
                        .position(mousePosition)
                        .allowsHitTesting(false)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Bottom Toolbar
            HStack(spacing: 20) {
                Button(action: { webViewStore.goBack() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                .disabled(!canGoBack)
                
                Button(action: { webViewStore.goForward() }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                .disabled(!canGoForward)
                
                Button(action: { /* New tab */ }) {
                    Image(systemName: "plus")
                        .font(.title2)
                }
                
                Button(action: { showQuickMenu = true }) {
                    ZStack {
                        Image(systemName: "square.grid.2x2")
                            .font(.title2)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8, height: 8)
                            .offset(x: 10, y: -10)
                    }
                }
                
                Button(action: { showQuickMenu = true }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            
            // Trackpad
            TrackpadView(mousePosition: $mousePosition, webViewStore: webViewStore)
                .frame(height: 200)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding()
        }
        .sheet(isPresented: $showQuickMenu) {
            QuickMenuView()
        }
        .onReceive(webViewStore.$canGoBack) { canGoBack = $0 }
        .onReceive(webViewStore.$canGoForward) { canGoForward = $0 }
        .onReceive(webViewStore.$isLoading) { isLoading = $0 }
        .navigationTitle("Browser")
        .navigationBarTitleDisplayMode(.inline)
    }
}

class WebViewStore: NSObject, ObservableObject {
    let webView: WKWebView
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var isLoading = false
    
    override init() {
        let config = WKWebViewConfiguration()
        // Desktop User-Agent
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
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    BrowserView()
}
