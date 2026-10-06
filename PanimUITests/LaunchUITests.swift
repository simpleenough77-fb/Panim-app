import XCTest

@MainActor
final class LaunchUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchShowsProductNameAndEarlyDevelopmentStatus() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.staticTexts["Panim"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts["Early development"].exists)
    }
}
