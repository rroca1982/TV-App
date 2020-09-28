//
//  ShowDetailsViewModelTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest
@testable import TV_App

class ShowDetailsViewModelTests: XCTestCase {

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
    
    func testInitViewModelSuccessful() {
        // Given
        if let show = model?.first {
            let viewModel = ShowDetailsViewModel(model: show)
            
            // Then
            XCTAssertNotNil(viewModel)
        } else {
            XCTFail("Model is nil")
        }
    }
    
    func testAllAtributesTrueFromModel() {
        // Given
        if let show = model?.first {
            let viewModel = ShowDetailsViewModel(model: show)
            
            // Then
            XCTAssertEqual(viewModel.tvShowTitle, "Under the Dome")
            
            XCTAssertEqual(viewModel.posterImageURL, URL.init(string: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg")!)
            
            XCTAssertEqual(viewModel.posterPlaceholderImage, UIImage.init(named: "posterPlaceholderLarge"))
            
            XCTAssertEqual(viewModel.runtime, "60 min")
            XCTAssertEqual(viewModel.time, "22:00")
            XCTAssertEqual(viewModel.days, "Thursday")
            
            XCTAssertEqual(viewModel.summary?.string, "Under the Dome is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town\'s inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.")
        } else {
            XCTFail("Model is nil")
        }
    }
}
