//
//  RecepieUITests.swift
//  RecepieUITests
//
//  Created by Muhammed salih T A on 27/01/22.
//

import XCTest
@testable import Recepie

class RecepieUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoadedItemList() throws {
        let app = XCUIApplication()
        app.launchEnvironment["IS_UI_TESTING"] = "1"
        app.launchEnvironment["USE_LOCAL_TEST_DATA"] = "1"
        app.launchEnvironment["RESPONSE." + "RecepieList"] = loadStubString(name: "RecepieList")
        
        app.launch()
        //  yes app traced the collection view
        XCTAssert(app.collectionViews["UICollectionView"].waitForExistence(timeout: 1.5))
        let collectionView = app.collectionViews["UICollectionView"]
        XCTAssert(collectionView.cells["Recepie.ReceipieListCell.1"].waitForExistence(timeout: 1.5))
        XCTAssertTrue(collectionView.cells.count == 5, "Loaded Cells")
    }
    
    func testLoadedItemDetail() throws {
        let app = XCUIApplication()
        app.launchEnvironment["IS_UI_TESTING"] = "1"
        app.launchEnvironment["USE_LOCAL_TEST_DATA"] = "1"
        app.launchEnvironment["RESPONSE.RecepieList"] = loadStubString(name: "RecepieList")
        app.launch()
        
        //  yes app traced the collection view
        let _ = app.collectionViews["UICollectionView"].waitForExistence(timeout: 1.5)
        let collectionView = app.collectionViews["UICollectionView"]
        let _ = collectionView.cells["Recepie.ReceipieListCell.1"].waitForExistence(timeout: 1.5)
        collectionView.cells.firstMatch.tap()
        XCTAssert(app.staticTexts["UILabel"].waitForExistence(timeout: 1.5))
        XCTAssertEqual(app.staticTexts["UILabel"].label,"cerulean")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCTestCase{
    func loadStub(name: String, extension: String = "json") -> URL? {
        let bundle = Bundle(for: type(of: self))

        let url = bundle.url(forResource: name, withExtension: `extension`)

        return url
    }
    
    func loadStubString(name: String, extension: String = "json") -> String? {
        return loadStub(name: name, extension: `extension`)?.absoluteString
    }
}
