//
//  CountryManager.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 06/06/24.
//

// MARK: File managing the url request to the restCountries server

import Foundation

class CountryManagerApiRequest {
    
    func fetchCountry(_ countryName: String, completion: @escaping ([CountryData]?, CountryManagerError?) -> Void) {
        let baseCountryURL = "https://restcountries.com/v3.1/"
        let endpoint: String
        if countryName.lowercased() == "all" {
            endpoint = "all?fields=name,flag"
        } else if countryName == "filter" {
            endpoint = "all?fields=name,flag,region,languages"
        } else {
            endpoint = "name/\(countryName)?fields=name,capital,region,latlng,flag,population,timezones,languages,unMember"
        }
        let urlString = "\(baseCountryURL)\(endpoint)"
        print(urlString)
        performRequest(urlString, completion: completion)
    }
    
    private func performRequest(_ urlString: String, completion: @escaping ([CountryData]?, CountryManagerError?) -> Void) {
        
        // Create URL
        if let url = URL(string: urlString) {
            
            // Create URL Session
            let session = URLSession(configuration: .default)
            
            // Session Task
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil, CountryManagerError.failedRequest)
                    return
                }
                if let receivedData = data {
                    let decodedData = self.parseJSON(countryData: receivedData)
                    completion(decodedData, nil)
                    
                } else {
                    print("No data received")
                    completion(nil, CountryManagerError.invalidResponseModel)
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