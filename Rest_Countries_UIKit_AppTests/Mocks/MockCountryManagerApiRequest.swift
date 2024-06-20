//
//  MockCountryManagerApiRequest.swift
//  Rest_Countries_UIKit_AppTests
//
//  Created by Stefano Zhao on 18/06/24.
//

//import Foundation
//@testable import IliadTest_iOS_UIKit
//
//class MockCountryManagerApiRequest: CountryManagerApiRequestProtocol {
//    
//    var isSingUpMetodCalled: Bool = false
//    var shouldReturnError: Bool = false
//    
//    func fetchCountry (countryName: String, completion: @escaping ([IliadTest_iOS_UIKit.CountryData]?, IliadTest_iOS_UIKit.CountryManagerError?) -> Void) {
//            
//        isSingUpMetodCalled = true
//        
//        if shouldReturnError {
//            completion(nil, CountryManagerError.failedRequest)
//        } else {
//            
//            let responseModel = [CountryData(name: Name(common: "test", official: "test"), capital: ["test"], region: "test", latlng: [0], flag: "test", population: 1, timezones: ["test"], languages: ["test" : "test"], unMember: false),CountryData(name: Name(common: "test", official: "test"), capital: ["test"], region: "test", latlng: [0], flag: "test", population: 1, timezones: ["test"], languages: ["test" : "test"], unMember: false)]
//            completion(responseModel, nil)
//        }
//    }
//}
