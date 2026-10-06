import SwiftUI

@main
struct PanimApp: App {
    init() {
        BrandFonts.registerBundledFonts()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
