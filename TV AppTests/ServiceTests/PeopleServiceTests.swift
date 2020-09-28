//
//  PeopleServiceTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest

@testable import TV_App

class PeopleServiceTests: XCTestCase {
    var peopleService: PeopleService!
    
    override func setUp() {
        super.setUp()
        peopleService = PeopleService()
    }
    
    override func tearDown() {
        peopleService = nil
        super.tearDown()
    }
    
    func testFetchCreditsCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        let personID = 100
        peopleService.fetchCredits(personID: personID) { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchCreditsGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        let personID = 100
        peopleService.fetchCredits(personID: personID) { (result) in
            switch result {
            case .Success(let shows):
                XCTAssertNotNil(shows)
                
                promise.fulfill()
            case .Failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
