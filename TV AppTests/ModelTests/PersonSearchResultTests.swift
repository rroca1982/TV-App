//
//  PersonSearchResultTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest
@testable import TV_App

class PersonSearchResultTests: XCTestCase {
    var decoder: JSONDecoder!
    
    var personSearchResultLocalJsonData: Data!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        
        setupJson(resource: "PersonSearchResultSample")
    }
    
    func setupJson(resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                switch resource {
                case "PersonSearchResultSample":
                    personSearchResultLocalJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
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
        
        personSearchResultLocalJsonData = nil
        
        super.tearDown()
    }
    
    func testInitWithShowSearchResultLocalData() {
        // Given
        let results = try? PersonSearchResult.fromJson(data: personSearchResultLocalJsonData)
        
        // When
        guard let result = results?.first else {
            XCTFail("No data")
            return
        }
        
        // Then
        XCTAssertEqual(result.person.id, 172658)
        XCTAssertEqual(result.person.name, "Lauren Bush Lauren")
    }
}

