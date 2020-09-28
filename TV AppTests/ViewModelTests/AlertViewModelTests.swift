//
//  AlertViewModelTests.swift
//  TV AppTests
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import XCTest

@testable import TV_App

class AlertViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitInternalErrorModelSuccessful() {
        // Given
        let noDataError = InternalError.noDataError
        let unknownError = InternalError.unknownError
        
        // When
        let noDataViewModel = AlertViewModel.init(internalErrorModel: noDataError)
        let unknownViewModel = AlertViewModel.init(internalErrorModel: unknownError)
        
        // Then
        XCTAssertNotNil(noDataViewModel)
        XCTAssertNotNil(unknownViewModel)
    }
    
    func testInitNetworkErrorModelSuccessful() {
        // Given
        let timeoutViewModel = AlertViewModel.init(networkErrorModel: .timeout)
        let lostConnectionViewModel = AlertViewModel.init(networkErrorModel: .lostConnection)
        let secureConnectionViewModel = AlertViewModel.init(networkErrorModel: .secureConnectionFailed)
        let badURLViewModel = AlertViewModel.init(networkErrorModel: .badURL)
        let hostNotFoundViewModel = AlertViewModel.init(networkErrorModel: .hostNotFound)
        let notFoundViewModel = AlertViewModel.init(networkErrorModel: .resourceNotFound)
        let unknownViewModel = AlertViewModel.init(networkErrorModel: .unknownError)
        
        // Then
        XCTAssertNotNil(timeoutViewModel)
        XCTAssertNotNil(lostConnectionViewModel)
        XCTAssertNotNil(secureConnectionViewModel)
        XCTAssertNotNil(badURLViewModel)
        XCTAssertNotNil(hostNotFoundViewModel)
        XCTAssertNotNil(notFoundViewModel)
        XCTAssertNotNil(unknownViewModel)
    }
    
    func testInitErrorModelSuccessful() {
        
        let defaultError = NSError.init(domain: "Unknown error", code: 0, userInfo: nil)
        
        // When
        let defaultViewModel = AlertViewModel.init(genericErrorModel: defaultError)
        
        // Then
        XCTAssertNotNil(defaultViewModel)
    }
    
    func testAllAtributesFromInternalErrorModel() {
        // Given
        let noDataError = InternalError.noDataError
        let unknownError = InternalError.unknownError
        
        // When
        let noDataViewModel = AlertViewModel.init(internalErrorModel: noDataError)
        let unknownViewModel = AlertViewModel.init(internalErrorModel: unknownError)
        
        // Then
        XCTAssertEqual(noDataViewModel.title, "Not found".localized())
        XCTAssertEqual(noDataViewModel.message, "Your request did not return any data.".localized())
        
        XCTAssertEqual(unknownViewModel.title, "Unknown error".localized())
        XCTAssertEqual(unknownViewModel.message, "An unknown internal error occured, please check your internet connection and try again. If the error persists, please contact support.".localized())
    }
    
    func testAllAtributesFromNetworkErrorModel() {
        
        // Given
        let timeoutViewModel = AlertViewModel.init(networkErrorModel: .timeout)
        let lostConnectionViewModel = AlertViewModel.init(networkErrorModel: .lostConnection)
        let secureConnectionViewModel = AlertViewModel.init(networkErrorModel: .secureConnectionFailed)
        let badURLViewModel = AlertViewModel.init(networkErrorModel: .badURL)
        let hostNotFoundViewModel = AlertViewModel.init(networkErrorModel: .hostNotFound)
        let notFoundViewModel = AlertViewModel.init(networkErrorModel: .resourceNotFound)
        let unknownViewModel = AlertViewModel.init(networkErrorModel: .unknownError)
        
        // Then
        XCTAssertEqual(timeoutViewModel.title, "Connection Timeout".localized())
        XCTAssertEqual(timeoutViewModel.message, "The connection timed out, please check your internet connection and try again.".localized())
        
        XCTAssertEqual(lostConnectionViewModel.title, "Lost connection".localized())
        XCTAssertEqual(lostConnectionViewModel.message, "You are not connected to the Internet, please check your connection and try again.".localized())
        
        XCTAssertEqual(secureConnectionViewModel.title, "Could not establish connection".localized())
        XCTAssertEqual(secureConnectionViewModel.message, "We could not establish a secure connection to the server, please check your internet connection and try again. If the problem persists, please contact support.".localized())
        
        XCTAssertEqual(notFoundViewModel.title, "Not found".localized())
        XCTAssertEqual(notFoundViewModel.message, "The resource you are trying to reach does not exist.".localized())
        
        XCTAssertEqual(badURLViewModel.title, "Bad URL".localized())
        XCTAssertEqual(badURLViewModel.message, "There is something wrong with the URL you are trying to access. Please try again in a few minutes or contact support if the problem persists.".localized())
        
        XCTAssertEqual(hostNotFoundViewModel.title, "Server not found".localized())
        XCTAssertEqual(hostNotFoundViewModel.message, "We could not establish a connection to the server, please check your internet connection and try again. If the problem persists, please contact support.".localized())
        
        XCTAssertEqual(unknownViewModel.title, "Unknown error".localized())
        XCTAssertEqual(unknownViewModel.message, "An unknown network error occured, please check your internet connection and try again. If the error persists, please contact support.".localized())
    }
    
    func testAllAtributesFromErrorModel() {
        let defaultError = NSError.init(domain: "Unknown error", code: 0, userInfo: nil)
        
        // When
        let defaultViewModel = AlertViewModel.init(genericErrorModel: defaultError)
        
        // Then
        XCTAssertEqual(defaultViewModel.title, "Unknown error".localized())
        XCTAssertEqual(defaultViewModel.message, "An unknown internal error occured, please check your internet connection and try again. If the error persists, please contact support.".localized())
    }
}

