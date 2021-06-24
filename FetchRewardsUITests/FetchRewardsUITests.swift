//
//  FetchRewardsUITests.swift
//  FetchRewardsUITests
//
//  Created by Prithiv Dev on 10/06/21.
//

import XCTest

class FetchRewardsUITests: XCTestCase {

    
    
    //test the tableview end
    func testTableViewEnd() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tableview = app.tables.firstMatch
        let cell = tableview.staticTexts["blank text"]

         //Swipe down until it is visible
         while !cell.exists {
             app.swipeUp()
         }

         //Interact with it when visible
         cell.tap()
    }
    
    
    //test how smooth the table view scrolls
    func testTableViewScrollPerformence() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let tableview = app.tables.firstMatch
        
        
        
        let measureOptions = XCTMeasureOptions()
        measureOptions.invocationOptions = [.manuallyStop]
        
        if #available(iOS 13.0, *) {
            if #available(iOS 14.0, *) {
                measure(metrics: [XCTOSSignpostMetric.scrollDecelerationMetric], options: measureOptions) {
                    tableview.swipeUp(velocity: .fast)
                    stopMeasuring()
                    tableview.swipeUp(velocity: .slow)
                    
                }
            } else {
                // Fallback on earlier versions
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    
    
    
}
