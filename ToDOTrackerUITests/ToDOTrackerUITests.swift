//
//  ToDOTrackerUITests.swift
//  ToDOTrackerUITests
//
//  Created by Reginald Grant on 6/22/26.
//

import XCTest

final class ToDOTrackerUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLaunchEnglish() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        // Look foe header on intinal screen
        let header = app.staticTexts["Who is working today?"]
        XCTAssertTrue(header.exists, "The header is not displaying the correct message")
    
    }
    
    func testLaunchSpanish() {
        app.launchArguments = ["-AppleLanguages", "(es)"]
        app.launch()
        
        let header = app.staticTexts["¿Quién está trabajando hoy?"]
        XCTAssertTrue(header.exists, "The header is not displaying the correct message in spanish")
    }
    
    func testLaunchJapanese() {
        app.launchArguments = ["-AppleLanguages", "(ja-JP)"]
        app.launch()
        
        let header = app.staticTexts["今日働いているのは誰ですか"]
        XCTAssertTrue(header.exists, "The header is not displaying the correct message in Japanese")
    }
    
    func testLaunchArabic() {
        app.launchArguments = ["-AppleLanguages", "(ar)"]
        app.launch()
        
        let header = app.staticTexts["من يعمل اليوم؟"]
        XCTAssertTrue(header.exists, "The header is not displaying the correct message in Arabic")
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // XCUIAutomation Documentation
        // https://developer.apple.com/documentation/xcuiautomation
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
