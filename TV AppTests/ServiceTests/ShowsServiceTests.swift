//
//  ShowsServiceTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest
@testable import TV_App

class ShowsServiceTests: XCTestCase {

    var showsService: ShowsService!
    
    override func setUp() {
        super.setUp()
        showsService = ShowsService()
    }
    
    override func tearDown() {
        showsService = nil
        super.tearDown()
    }
    
    func testFetchAllShowsCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        let page = 1
        showsService.fetchAllShows(page: page) { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchAllShowsGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        let page = 1
        showsService.fetchAllShows(page: page) { (result) in
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
    
    func testFetchSeasonsCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        let showID = 1
        showsService.fetchSeasons(showID: showID) { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchSeasonsGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        let showID = 1
        showsService.fetchSeasons(showID: showID) { (result) in
            switch result {
            case .Success(let seasons):
                XCTAssertNotNil(seasons)
                
                promise.fulfill()
            case .Failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchEpisodesCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        let seasonID = 1
        showsService.fetchEpisodes(seasonID: seasonID) { (result) in            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchEpisodesGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        let seasonID = 1
        showsService.fetchEpisodes(seasonID: seasonID) { (result) in
            switch result {
            case .Success(let episodes):
                XCTAssertNotNil(episodes)
                
                promise.fulfill()
            case .Failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
