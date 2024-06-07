//
//  CountryData.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 06/06/24.
//

// https://restcountries.com/v3.1/name/Italy?fields=name,capital,region,latlng,flag,population,timezones
import Foundation

struct CountryData: Decodable {
    let name: Name
    let capital: [String]?
    let region: String?
    let latlng: [Double]?
    let flag: String?
    let population: Int?
    let timezones: [String]?
}

struct Name: Decodable {
    let common: String
    let official: String
}

