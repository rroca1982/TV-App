//
//  ShowListViewModelTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest
@testable import TV_App

class ShowListViewModelTests: XCTestCase {
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

    func testAddMoviesSuccessful() {
        // Given
        if let model = model {
            let viewModel = ShowListViewModel(service: ShowsService())
            
            viewModel.addItems(model)
            
            // Then
            XCTAssertNotNil(viewModel)
            XCTAssertEqual(viewModel.items.count, 240)
        } else {
            XCTFail("Model is nil")
        }
    }
    
    func testNumberOfRowsSuccessful() {
        // Given
        if let model = model {
            let viewModel = ShowListViewModel(service: ShowsService())
            
            viewModel.removeAllItems()
            viewModel.addItems(model)
            // Then
            XCTAssertNotNil(viewModel)
            XCTAssertEqual(viewModel.items.count, viewModel.numberOfRows(0))
        } else {
            XCTFail("Model is nil")
        }
    }

    func testRemoveItemsSuccessful() {
        // Given
        let viewModel = ShowListViewModel(service: ShowsService())
        
        viewModel.removeAllItems()

        // Then
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.items.count, 0)
    }
}
