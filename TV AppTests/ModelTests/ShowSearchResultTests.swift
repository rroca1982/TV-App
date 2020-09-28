//
//  ShowSearchResultTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest
@testable import TV_App

class ShowSearchResultTests: XCTestCase {
    var decoder: JSONDecoder!
    
    var showSearchResultLocalJsonData: Data!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        
        setupJson(resource: "ShowSearchResultSample")
    }
    
    func setupJson(resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                switch resource {
                case "ShowSearchResultSample":
                    showSearchResultLocalJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
                default:
                    break
                }
            } catch {
                print("Error parsing no image json")
            }
        }
    }
    
    override func tearDown() {
        decoder = nil
        
        showSearchResultLocalJsonData = nil
        
        super.tearDown()
    }
    
    func testInitWithShowSearchResultLocalData() {
        // Given
        let results = try? ShowSearchResult.fromJson(data: showSearchResultLocalJsonData)
        
        // When
        guard let result = results?.first else {
            XCTFail("No data")
            return
        }
        
        // Then
        XCTAssertEqual(result.show.id, 123)
        XCTAssertEqual(result.show.name, "Lost")
    }
}
