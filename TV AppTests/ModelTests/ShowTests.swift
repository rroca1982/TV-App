//
//  ShowTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest
@testable import TV_App

class ShowTests: XCTestCase {
    var decoder: JSONDecoder!
    
    var showLocalJsonData: Data!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        
        setupJson(resource: "ShowSample")
    }
    
    func setupJson(resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                switch resource {
                case "ShowSample":
                    showLocalJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
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
        
        showLocalJsonData = nil
        
        super.tearDown()
    }
    
    func testInitWithShowLocalData() {
        // Given
        let shows = try? Show.fromJson(data: showLocalJsonData)
        
        // When
        guard let show = shows?.first else {
            XCTFail("No data")
            return
        }
        
        // Then
        XCTAssertEqual(show.id, 1)
        XCTAssertEqual(show.name, "Under the Dome")
    }
}
