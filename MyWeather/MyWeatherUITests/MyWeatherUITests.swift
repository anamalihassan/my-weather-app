//
//  MyWeatherUITests.swift
//  MyWeatherUITests
//
//  Created by Ali Hassan on 03/11/2020.
//

import XCTest

class MyWeatherUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUIElements() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let locationLabel = app.staticTexts["locationLabel"]
        let summaryLabel = app.staticTexts["summaryLabel"]
        let tempLabel = app.staticTexts["tempLabel"]
        let apparentTempLabel = app.staticTexts["apparentTempLabel"]
        let dailyWeatherTV = app.tables["dailyWeatherTV"]
        let hourlyWeatherCV = app.collectionViews["hourlyWeatherCV"]
        XCTAssertTrue(locationLabel.exists)
        XCTAssertTrue(summaryLabel.exists)
        XCTAssertTrue(tempLabel.exists)
        XCTAssertTrue(apparentTempLabel.exists)
        XCTAssertTrue(dailyWeatherTV.exists)
        XCTAssertTrue(hourlyWeatherCV.exists)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
