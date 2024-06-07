//
//  CountryManager.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 06/06/24.
//

// MARK: File managing the url request to the restCountries server

import Foundation

class CountryManager {
    
    func fetchCountry(_ countryName: String, completion: @escaping ([CountryData]?) -> Void) {
        let baseCountryURL = "https://restcountries.com/v3.1/"
        let endpoint: String
        if countryName.lowercased() == "all" {
            endpoint = "all?fields=name,flag"
        } else {
            endpoint = "name/\(countryName)?fields=name,capital,region,latlng,flag,population,timezones"
        }
        let urlString = "\(baseCountryURL)\(endpoint)"
        print(urlString)
        performRequest(urlString, completion: completion)
    }
    
    private func performRequest(_ urlString: String, completion: @escaping ([CountryData]?) -> Void) {
        
        // Create URL
        if let url = URL(string: urlString) {
            
            // Create URL Session
            let session = URLSession(configuration: .default)
            
            // Session Task
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
                if let receivedData = data {
                    let decodedData = self.parseJSON(countryData: receivedData)
                    completion(decodedData)
                    
                } else {
                    print("No data received")
                    completion(nil)
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
            for country in decodedCountryData {
                print(country.name.common)
                if let capital = country.capital {
                    print("Capital: \(capital.joined(separator: ", "))")
                }
                if let region = country.region {
                    print("Region: \(region)")
                }
                if let latlng = country.latlng {
                    print("Coordinates: \(latlng.map { String($0) }.joined(separator: ", "))")
                }
                if let flag = country.flag {
                    print("Flag: \(flag)")
                }
                if let population = country.population {
                    print("Population: \(population)")
                }
                if let timezones = country.timezones {
                    print("Timezones: \(timezones.joined(separator: ", "))")
                }
            }
            return decodedCountryData
        } catch {
            print(error)
            return nil
        }
        
    }
}
