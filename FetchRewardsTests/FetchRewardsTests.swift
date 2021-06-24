//
//  FetchRewardsTests.swift
//  FetchRewardsTests
//
//  Created by Prithiv Dev on 10/06/21.
//

import XCTest
@testable import FetchRewards

class FetchRewardsTests: XCTestCase {

    private var backend = Backend()
    
    
    
    
    func emptyEventsCheck() {
        
        var events = [Event]()
                
        let query = "we8f7h"
        backend.fetchEventWithQuery(query: query, completionHandler: { allevents in
            events = allevents
        })
        
        if events.isEmpty {
            print("Successful")
        }
        
        //XCTAssertEqual(events, [])
        
    }
    
    
    
    
    

}
