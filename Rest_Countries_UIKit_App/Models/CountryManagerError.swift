//
//  CountryManagerError.swift
//  Rest_Countries_UIKit_App
//
//  Created by Stefano Zhao on 18/06/24.
//

import Foundation

enum CountryManagerError: Error, Equatable {
    
    case invalidRequestURLString
    case failedRequest
    case invalidResponseModel
    case timeout
}
