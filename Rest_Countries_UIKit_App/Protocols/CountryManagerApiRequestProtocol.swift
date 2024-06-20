//
//  CountryManagerApiRequestProtocol.swift
//  Rest_Countries_UIKit_App
//
//  Created by Stefano Zhao on 18/06/24.
//

import Foundation

protocol CountryManagerApiRequestProtocol {
    
    func fetchCountry (countryName: String, completionHandler: @escaping ([CountryData]?, CountryManagerError?) -> Void)
}
