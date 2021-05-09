//
//  NBA1UITests.swift
//  NBA1UITests
//
//  Created by Погос  on 10.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import XCTest

class NBA1UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
       app = XCUIApplication()
       app.launch()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testButtons() {
        
        
        let hallofFame = app.tabBars.buttons["Hall of Fame"]
        let GetStarted = app.buttons["Get Started"]
                
        let collectionViewsQuery = app.collectionViews
        let ans1 = collectionViewsQuery.buttons["Kevin Durant"]
        let ans2 = collectionViewsQuery.buttons["Kawhi Leonard"]
        let ans3 = collectionViewsQuery.buttons["Stephen Curry"]
        let ans4 = collectionViewsQuery.buttons["Russell Westbrook"]
        
        let ans5 = collectionViewsQuery.buttons["Anthony Davis"]
        let ans6 = collectionViewsQuery.buttons["Luka Dončić"]
        let ans7 = collectionViewsQuery.buttons["Chris Paul"]
        let ans8 = collectionViewsQuery.buttons["LeBron James"]
        
        let NextButton = app.buttons["Next >"]
        let HallOfFame = app.navigationBars["Hall of Fame"].buttons["Hall of Fame"]
        
        if hallofFame.isSelected {
            XCTAssertTrue(GetStarted.exists)
            if GetStarted.isSelected {
                 XCTAssertTrue(ans1.exists)
                 XCTAssertTrue(ans2.exists)
                 XCTAssertTrue(ans3.exists)
                 XCTAssertTrue(ans4.exists)
            }
            if NextButton.isSelected {
                XCTAssertTrue(ans5.exists)
                XCTAssertTrue(ans6.exists)
                XCTAssertTrue(ans7.exists)
                XCTAssertTrue(ans8.exists)
            }
            
            if HallOfFame.isSelected {
                 XCTAssertTrue(GetStarted.exists)
            }
        }
    
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
