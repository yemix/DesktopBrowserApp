import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    
    var body: some View {
        BrowserView(showSettings: $showSettings)
            .sheet(isPresented: $showSettings) {
                NavigationView {
                    SettingsView()
                        .navigationTitle("Einstellungen")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Fertig") { showSettings = false }
                            }
                        }
                }
            }
    }
}

#Preview {
    ContentView()
}
