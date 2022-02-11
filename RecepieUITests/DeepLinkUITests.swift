//
//  DeepLinkUITests.swift
//  RecepieUITests
//
//  Created by Muhammed salih T A on 04/02/22.
//

import XCTest

class DeepLinkUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLink() throws {
        let app = XCUIApplication()
        app.launchEnvironment["IS_UI_TESTING"] = "1"
        app.launchEnvironment["USE_LOCAL_TEST_DATA"] = "1"
        app.launchEnvironment["RESPONSE.RecepieList"] = loadStubString(name: "RecepieList")
        app.launch()
        openURLFromSafari("recepie://item?id=2")
        
        XCTAssert(app.staticTexts["UILabel"].waitForExistence(timeout: 1.5))
        XCTAssertEqual(app.staticTexts["UILabel"].label,"2")
        
    }
    
    private func openURLFromSafari(_ urlString: String) {
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        safari.terminate()
        safari.launch()
        
        // Make sure Safari is really running before asserting
        XCTAssert(safari.wait(for: .runningForeground, timeout: 5))
        
        // Type the deeplink and execute it
        let firstLaunchContinueButton = safari.buttons["Continue"]
        if firstLaunchContinueButton.exists {
            firstLaunchContinueButton.tap()
        }
        safari.buttons["URL"].tap()
        
        // On first safari launch, tutorial may appear
        let keyboardTutorialButton = safari.buttons["Continue"]
        if keyboardTutorialButton.exists {
            keyboardTutorialButton.tap()
        }
        safari.typeText(urlString)
        safari.buttons["Go"].tap()
        
        // For non-universial links (like gosite://) need to confirm open
        let confirmationButton = safari.staticTexts["Open"]
        _ = confirmationButton.waitForExistence(timeout: 2)
        if confirmationButton.exists {
            confirmationButton.tap()
        }
    }

}
