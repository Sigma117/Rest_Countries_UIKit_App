//
//  CountryManagerApiRequestTests.swift
//  Rest_Countries_UIKit_AppTests
//
//  Created by Stefano Zhao on 18/06/24.
//

import XCTest
@testable import Rest_Countries_UIKit_App

final class CountryManagerApiRequestTests: XCTestCase {

    var sut: CountryManagerApiRequest!
    
    override func setUpWithError() throws {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = CountryManagerApiRequest(urlBaseString: CountryManagerCostants.urlBaseRestCountrisApi, urlSession: urlSession)
    }

    override func tearDownWithError() throws {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }

    
    func testCountryManagerApiRequestTest_WhenGivenSuccessfullResponse_ReturnSuccess() {
        
        // Arragne
        let jsonString = "[{\"name\":{\"common\":\"Germany\",\"official\":\"FederalRepublicofGermany\",\"nativeName\":{\"deu\":{\"official\":\"BundesrepublikDeutschland\",\"common\":\"Deutschland\"}}},\"unMember\":true,\"capital\":[\"Berlin\"],\"region\":\"Europe\",\"languages\":{\"deu\":\"German\"},\"latlng\":[51,9],\"flag\":\"🇩🇪\",\"population\":1,\"timezones\":[\"UTC+01:00\"]}]"
        
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "CountryManagerApiRequest Response Expectation")
        
        // Act
        sut.fetchCountry(countryName: "") { (countryData, error) in
            
            // Assert
            XCTAssertEqual(countryData?.first?.name.common, "Germany")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
       
        
    }
    
    func testCountryManagerApiRequestTest_WhenReceiveDifferentHesonResponde_ErrorTakePlace() {
        // Arragne
        
        // Act
        
        // Assert
        
    }

}
