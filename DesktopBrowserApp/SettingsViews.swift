import SwiftUI

struct SettingsView: View {
    @State private var startOption = "Vorherige Tabs wiederherstellen"
    @State private var homepage = "https://google.de"
    @State private var searchEngine = "Google"
    @State private var userAgent = "Chrome (Windows)"
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Startoptionen")) {
                    NavigationLink("Beim Start", destination: Text("Optionen"))
                    Text(startOption)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Startseite")) {
                    TextField("URL", text: $homepage)
                    Button("Anwenden") {
                        // Apply homepage
                    }
                    .foregroundColor(.blue)
                }
                
                Section(header: Text("Suchmaschine")) {
                    HStack {
                        Text("Standardsuchmaschine")
                        Spacer()
                        Text(searchEngine)
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.up.chevron.down")
                    }
                }
                
                Section(header: Text("User-Agent")) {
                    HStack {
                        Text("Voreinstellung")
                        Spacer()
                        Text(userAgent)
                            .foregroundColor(.gray)
                    }
                    Text("Aktuelle UA")
                        .font(.caption)
                    Text("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                NavigationLink("Simulierter Computer") {
                    SimulatedComputerView()
                }
                
                NavigationLink("Cache-Verwaltung") {
                    CacheView()
                }
            }
            .navigationTitle("Browser")
        }
    }
}

struct SimulatedComputerView: View {
    @State private var pointerSensitivity: Double = 100
    @State private var scrollSpeed: Double = 100
    @State private var naturalScroll = true
    @State private var resolutionWidth = "1440"
    @State private var resolutionHeight = "1295"
    @State private var zoom: Double = 100
    
    var body: some View {
        List {
            Section(header: Text("Desktop-Auflösung")) {
                HStack {
                    Text("Voreinstellung")
                    Spacer()
                    Text("Benutzerdefiniert")
                    Image(systemName: "chevron.up.chevron.down")
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Seitenzum")
                        Spacer()
                        Text("\(Int(zoom))%")
                    }
                    Slider(value: $zoom, in: 50...200)
                }
                
                HStack {
                    TextField("Breite", text: $resolutionWidth)
                        .keyboardType(.numberPad)
                    Text("×")
                    TextField("Höhe", text: $resolutionHeight)
                        .keyboardType(.numberPad)
                    Button("Anwenden") {}
                        .foregroundColor(.blue)
                }
            }
            
            Section(header: Text("Trackpad")) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Zeigerempfindlichkeit")
                        Spacer()
                        Text("\(Int(pointerSensitivity))%")
                    }
                    Slider(value: $pointerSensitivity, in: 50...200)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Scrollgeschwindigkeit")
                        Spacer()
                        Text("\(Int(scrollSpeed))%")
                    }
                    Slider(value: $scrollSpeed, in: 50...200)
                }
                
                Toggle("Natürliche Scrollrichtung", isOn: $naturalScroll)
            }
            
            Section(header: Text("Interaktionsmodus")) {
                HStack {
                    Text("Modus")
                    Spacer()
                    Text("PC-Stil")
                    Image(systemName: "chevron.up.chevron.down")
                }
            }
        }
        .navigationTitle("Simulierter Computer")
    }
}

struct CacheView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    VStack {
                        Text("33")
                            .font(.largeTitle.bold())
                        Text("Websites")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("44")
                            .font(.largeTitle.bold())
                        Text("Cache-Einträge")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("Unbekannt")
                            .font(.title2.bold())
                        Text("Cache-Größe")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
            }
            
            Section {
                Text("Websites nach Domain filtern")
                    .foregroundColor(.gray)
            }
            
            Section {
                ForEach(["2mdn.net", "adnxs.com", "apple.com"], id: \.self) { domain in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(domain)
                                .font(.headline)
                            Text("Disk Cache")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Unbekannte Größe")
                            Text("1 Elemente")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Cache-Verwaltung")
        .toolbar {
            Button("Leeren") {}
            Button("Aktualisieren") {}
        }
    }
}
