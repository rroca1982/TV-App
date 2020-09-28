//
//  CastCreditTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest
@testable import TV_App

class CastCreditTests: XCTestCase {
    var decoder: JSONDecoder!
    
    var castCreditLocalJsonData: Data!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        
        setupJson(resource: "CastCreditSample")
    }
    
    func setupJson(resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                switch resource {
                case "CastCreditSample":
                    castCreditLocalJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
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
        
        castCreditLocalJsonData = nil
        
        super.tearDown()
    }
    
    func testInitWithCastCreditLocalData() {
        // Given
        let castCredit = try? CastCredit.fromJson(data: castCreditLocalJsonData)
        
        // When
        guard let cast = castCredit?.first else {
            XCTFail("No data")
            return
        }
        
        // Then
        XCTAssertEqual(cast.embedded.show.id, 1)
        XCTAssertEqual(cast.embedded.show.name, "Under the Dome")
    }
}
