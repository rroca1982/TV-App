//
//  SearchServiceTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest

@testable import TV_App

class SearchServiceTests: XCTestCase {
    var searchService: SearchService!
    
    override func setUp() {
        super.setUp()
        searchService = SearchService()
    }
    
    override func tearDown() {
        searchService = nil
        super.tearDown()
    }
    
    func testSearchShowsCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        let searchTerm = "Lost"
        searchService.searchShows(title: searchTerm) { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchShowsGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        let searchTerm = "Lost"
        searchService.searchShows(title: searchTerm) { (result) in
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
    
    func testSearchPeopleCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        let searchTerm = "Lost"
        searchService.searchPeople(name: searchTerm) { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchPeopleGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        let searchTerm = "Lost"
        searchService.searchPeople(name: searchTerm) { (result) in
            switch result {
            case .Success(let people):
                XCTAssertNotNil(people)
                
                promise.fulfill()
            case .Failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

