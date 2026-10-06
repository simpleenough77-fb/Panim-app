import CoreText
import Foundation

/// Atkinson Hyperlegible Next (SIL OFL 1.1), bundled unmodified from Brand v1.0.1.
/// The file is a variable font (weight axis 200-800); these are its named instances.
/// Registered at runtime from the app bundle: nothing is fetched remotely.
enum BrandFonts {
    static let family = "Atkinson Hyperlegible Next"
    static let regular = "AtkinsonHyperlegibleNext-Regular"            // weight 400
    static let semibold = "AtkinsonHyperlegibleNext-Regular_SemiBold"  // weight 600

    /// Returns true when the font is available to the process (including when it was already registered).
    @discardableResult
    static func registerBundledFonts(bundle: Bundle = .main) -> Bool {
        guard let url = bundle.url(forResource: "Atkinson", withExtension: "ttf") else { return false }
        var error: Unmanaged<CFError>?
        if CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error) { return true }
        if let cfError = error?.takeRetainedValue(),
           CFErrorGetCode(cfError) == CTFontManagerError.alreadyRegistered.rawValue {
            return true
        }
        return false
    }
}
