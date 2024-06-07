//
//  CountryManager.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 06/06/24.
//

// MARK: File managing the url request to the restCountries server

import Foundation

struct CountryManager {
    
    let baseCountryURL = "https://restcountries.com/v3.1/"
    
    func fetchCountry(_ countryName: String) {
        let endpoint: String
        if countryName.lowercased() == "all" {
            endpoint = "all?fields=name"
        } else {
            endpoint = "name/\(countryName)?fields=name,capital,region,latlng,flag,population,timezones"
        }
        let urlString = "\(baseCountryURL)\(endpoint)"
        print(urlString)
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        
        // Create URL
        if let url = URL(string: urlString) {
            
            // Create URL Session
            let session = URLSession(configuration: .default)
            
            // Session Task
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                if let receivedData = data {
                    self.parseJSON(countryData: receivedData)
                    
                } else {
                    print("No data received")
                }
            }
            // Start Task
            task.resume()
        }
    }
    
    func parseJSON(countryData: Data) {
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
        } catch {
            print(error)
        }
        
    }
}
