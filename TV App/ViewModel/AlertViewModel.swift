//
//  AlertViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

struct AlertViewModel {
    
    // MARK: - Properties
    var title: String
    var message: String
        
    // MARK: - Init
    init(networkErrorModel: SwiftyRestKitError) {
        switch networkErrorModel {
        case .timeout:
            title = "Connection Timeout".localized()
            message = "The connection timed out, please check your internet connection and try again.".localized()
        case .secureConnectionFailed:
            title = "Could not establish connection".localized()
            message = "We could not establish a secure connection to the server, please check your internet connection and try again. If the problem persists, please contact support.".localized()
        case .badURL:
            title = "Bad URL".localized()
            message = "There is something wrong with the URL you are trying to access. Please try again in a few minutes or contact support if the problem persists.".localized()
        case .hostNotFound:
            title = "Server not found".localized()
            message = "We could not establish a connection to the server, please check your internet connection and try again. If the problem persists, please contact support.".localized()
        case .lostConnection:
            title = "Lost connection".localized()
            message = "You are not connected to the Internet, please check your connection and try again.".localized()
        case .resourceNotFound:
            title = "Not found".localized()
            message = "The resource you are trying to reach does not exist.".localized()
        default:
            title = "Unknown error".localized()
            message = "An unknown network error occured, please check your internet connection and try again. If the error persists, please contact support.".localized()
        }
    }
    
    init(internalErrorModel: InternalError) {
        switch internalErrorModel {
        case .noDataError:
            title = "Not found".localized()
            message = "Your request did not return any data.".localized()
            
        default:
            title = "Unknown error".localized()
            message = "An unknown internal error occured, please check your internet connection and try again. If the error persists, please contact support.".localized()
        }
    }
    
    init(genericErrorModel: Error) {
        if let error = genericErrorModel as NSError? {
            switch error.code {
            
            default:
                title = "Unknown error".localized()
                message = "An unknown internal error occured, please check your internet connection and try again. If the error persists, please contact support.".localized()
            }
        } else {
            title = "There was an error".localized()
            message = genericErrorModel.localizedDescription
        }
    }
}

