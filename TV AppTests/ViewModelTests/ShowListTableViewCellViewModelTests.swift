//
//  ShowListTableViewCellViewModelTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest
@testable import TV_App

class ShowListTableViewCellViewModelTests: XCTestCase {
    
    var model: [Show]?

    override func setUp() {
        super.setUp()
        
        if let completePath = Bundle.main.path(forResource: "ShowSample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: completePath), options: .mappedIfSafe)
                model = try? Show.fromJson(data: data)
            } catch {
                print("Error initializing model")
            }
        }
    }
    
    override func tearDown() {
        model = nil
        
        super.tearDown()
    }
    
    func testInitCompleteModelSuccessful() {
        // Given
        if let show = model?.first {
            let viewModel = ShowListTableViewCellViewModel(model: show)
            
            // Then
            XCTAssertNotNil(viewModel)
        } else {
            XCTFail("Model is nil")
        }
    }
    
    func testAllAtributesTrueFromModel() {
        // Given
        if let show = model?.first {
            let viewModel = ShowListTableViewCellViewModel(model: show)

            // Then
            XCTAssertEqual(viewModel.showTitle, "Under the Dome")

            XCTAssertEqual(viewModel.posterImageURL, URL.init(string: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg")!)

            XCTAssertEqual(viewModel.posterPlaceholderImage, UIImage.init(named: "posterPlaceholderLarge"))
            
            XCTAssertEqual(viewModel.genre, "Drama")
        } else {
            XCTFail("Model is nil")
        }
    }
    
}
