//
//  CountryManagerError.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 18/06/24.
//

import Foundation

enum CountryManagerError: Error, Equatable {
    
    case invalidRequestURL
    case failedRequest
    case invalidResponseModel
    case timeout
}
