//
//  CountryManagerTest.swift
//  IliadTest_iOS_UIKitTests
//
//  Created by Stefano Zhao on 09/06/24.
//

import XCTest
@testable import IliadTest_iOS_UIKit

final class CountryManagerTest: XCTestCase {
    
    var sut: CountryManager!
    var countryData: [CountryData]!

    override func setUpWithError() throws {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MonkURLProtocol.self]
        let urlSession = URLSession(configuration: config)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountryManager_WhenGivenSuccessfullResponse_ReturnSuccess() {
        
        let jsonString = "{\"name\":\"italy\"}"
        MonkURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Api request response ad expected")
        }
    
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
