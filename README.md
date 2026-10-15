# Desktop Browser App (iOS)

Eine iOS-App, die einen PC-Desktop-Browser auf dem iPhone simuliert – basierend auf den bereitgestellten Screenshots.

## Funktionen

- Browser mit Desktop-User-Agent (Chrome/Windows)
- Adressleiste, Navigation, Lesezeichen-Platzhalter
- **Trackpad** für Maus-ähnliche Steuerung (Drag = Pointer bewegen, Tap = Klick)
- Schnellmenü mit häufigen Aktionen
- Einstellungen für Browser (Startseite, Suchmaschine, User-Agent)
- Simulierter Computer: Auflösung, Zoom, Trackpad-Empfindlichkeit, Scroll-Einstellungen
- Cache-Verwaltung (UI, echte Daten je nach WebKit-Limitierungen)

## Einrichtung in Xcode

1. Öffne Xcode und erstelle ein neues Projekt: **iOS App** → SwiftUI → Interface: SwiftUI, Language: Swift.
2. Benenne es z.B. `DesktopBrowserApp`.
3. Lösche die automatisch generierten Dateien (`ContentView.swift` etc.).
4. Kopiere alle `.swift`-Dateien aus diesem Ordner in dein Xcode-Projekt (Add Files to Project).
5. Stelle sicher, dass alle Dateien im Target aktiviert sind.
6. Build & Run auf einem Gerät oder Simulator (iOS 17+ empfohlen).

## Hinweise

- Die Maus-Pointer-Simulation und Klick-Events sind vereinfacht. Für vollständige Desktop-Interaktion (JS-Events, Scroll, Right-Click etc.) muss die Trackpad-Logik erweitert werden (z.B. mit `WKWebView.evaluateJavaScript` oder Custom Gestures).
- WebKit gibt keine präzisen Cache-Größen preis – daher "Unbekannt".
- Alle Texte sind auf Deutsch.
- Erweiterungen: Tabs, Downloads, Verlauf, Lesezeichen-Persistenz mit SwiftData, Fullscreen, Screenshot etc.

Viel Spaß beim Weiterentwickeln!
