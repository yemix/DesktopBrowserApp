import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BrowserView()
                .tabItem {
                    Label("Browser", systemImage: "globe")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Label("Einstellungen", systemImage: "gear")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
