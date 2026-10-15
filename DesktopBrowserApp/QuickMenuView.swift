import SwiftUI

struct QuickMenuView: View {
    @Environment(\.dismiss) private var dismiss
    
    let frequentItems = [
        ("Einstellungen", "gear"),
        ("Lesezeichen", "star"),
        ("Verlauf", "clock"),
        ("Downloads", "arrow.down.circle")
    ]
    
    let displayItems = [
        ("Vollbild einschalten", "rectangle.expand"),
        ("Externe Anzeige", "display")
    ]
    
    let pageItems = [
        ("Suchen", "magnifyingglass"),
        ("Screenshot", "camera"),
        ("Im Standardbrowser öffnen", "safari"),
        ("Esc", "escape")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("HAUFIG VERWENDET")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(frequentItems, id: \.0) { item in
                            MenuButton(title: item.0, icon: item.1)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("ERWEITERTE ANZEIGE")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(displayItems, id: \.0) { item in
                            MenuButton(title: item.0, icon: item.1)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("AKTUELLE SEITE")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(pageItems, id: \.0) { item in
                            MenuButton(title: item.0, icon: item.1)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("WEB-ENTWICKLERTOOLS")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    // Placeholder for more items
                }
                .padding(.vertical)
            }
            .navigationTitle("Schnellmenu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Schließen") { dismiss() }
                }
            }
        }
    }
}

struct MenuButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}
