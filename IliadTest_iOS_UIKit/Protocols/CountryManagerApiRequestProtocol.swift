//
//  CountryManagerApiRequestProtocol.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 18/06/24.
//

import Foundation

protocol CountryManagerApiRequestProtocol {
    
    func fetchCountry (countryName: String, completionHandler: @escaping ([CountryData]?, CountryManagerError?) -> Void)
}
