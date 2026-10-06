import UIKit
import XCTest
@testable import Panim

/// Checks the shipped bundle against Panim's privacy-by-default and brand-integration requirements.
final class BundleContractTests: XCTestCase {
    private var info: [String: Any] { Bundle.main.infoDictionary ?? [:] }

    func testNoPermissionUsageDescriptionsAreDeclared() {
        let usageKeys = info.keys.filter { $0.hasSuffix("UsageDescription") }
        XCTAssertEqual(usageKeys, [], "The foundation build must request no permissions.")
    }

    func testNoQueriedSchemesAndNoTransportSecurityExceptions() {
        XCTAssertNil(info["LSApplicationQueriesSchemes"])
        XCTAssertNil(info["NSAppTransportSecurity"])
    }

    func testTargetsIPhoneAndIPad() {
        let family = (info["UIDeviceFamily"] as? [Int]) ?? []
        XCTAssertEqual(Set(family), [1, 2])
    }

    func testAppIconFromBrandCatalogIsDeclared() {
        let description = String(describing: info["CFBundleIcons"] ?? "") + String(describing: info["CFBundleIcons~ipad"] ?? "")
        XCTAssertTrue(description.contains("AppIcon"), "CFBundleIcons should reference the AppIcon set: \(description)")
    }

    func testBundledBrandFontRegistersAndLoadsBothUsedWeights() {
        XCTAssertTrue(BrandFonts.registerBundledFonts())
        XCTAssertNotNil(UIFont(name: BrandFonts.regular, size: 18))
        XCTAssertNotNil(UIFont(name: BrandFonts.semibold, size: 18))
    }

    func testFontLicenseShipsWithTheFont() {
        XCTAssertNotNil(Bundle.main.url(forResource: "Atkinson.OFL", withExtension: "txt"))
    }
}
