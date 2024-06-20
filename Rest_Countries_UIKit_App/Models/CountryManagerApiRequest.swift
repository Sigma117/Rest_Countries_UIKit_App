//
//  CountryManager.swift
//  Rest_Countries_UIKit_App
//
//  Created by Stefano Zhao on 06/06/24.
//

// MARK: File managing the url request to the restCountries server

import Foundation

class CountryManagerApiRequest: CountryManagerApiRequestProtocol {
    
    private var urlBaseString: String
    private var urlSession: URLSession
     
    required init(urlBaseString: String, urlSession: URLSession = .shared) {
        self.urlBaseString  = urlBaseString
        self.urlSession = urlSession
    }
    
    func fetchCountry (countryName: String, completionHandler: @escaping ([CountryData]?, CountryManagerError?) -> Void) {
        let endpoint: String
        
        switch countryName {
        case "all":
            endpoint = "all?fields=name,flag"
        case "filter":
            endpoint = "all?fields=name,flag,region,languages"
        default:
            endpoint = "name/\(countryName)?fields=name,capital,region,latlng,flag,population,timezones,languages,unMember"
        }
        
        let urlString = "\(urlBaseString)\(endpoint)"
        print(urlString)
        performRequest(urlString, completionHandler: completionHandler)
    }

    
    private func performRequest(_ urlString: String, completionHandler: @escaping ([CountryData]?, CountryManagerError?) -> Void) {
        
        // Create URL
        if let url = URL(string: urlString) {
            
            // Create URL Session
//            let urlSession = URLSession(configuration: .default)
            
            // Session Task
            let task = urlSession.dataTask(with: url) { data, response, error in
                if let _ = error {
                    completionHandler(nil, CountryManagerError.failedRequest)
                    return
                }
                if let receivedData = data {
                    let decodedData = self.parseJSON(countryData: receivedData)
                    completionHandler(decodedData, nil)
                    
                } else {
                    print("No data received")
                    completionHandler(nil, CountryManagerError.invalidResponseModel)
                }
            }
            // Start Task
            task.resume()
        }
    }
    
    private func parseJSON(countryData: Data) -> [CountryData]? {
        let decoder = JSONDecoder()
        
        do{
            let decodedCountryData = try decoder.decode([CountryData].self, from: countryData)
            return decodedCountryData
        } catch {
            print(error)
            return nil
        }
        
    }
}
