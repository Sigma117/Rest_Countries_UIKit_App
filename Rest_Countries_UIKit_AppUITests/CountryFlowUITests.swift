//
//  CountryFlowUITests.swift
//  Rest_Countries_UIKit_AppUITests
//
//  Created by Stefano Zhao on 02/07/24.
//

import XCTest
@testable import Rest_Countries_UIKit_App

final class CountryFlowUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var countryTable: XCUIElementQuery!
    private var countrySearchBar: XCUIElementQuery!
    private var filterButton: XCUIElement!
    private var resetFilterButton: XCUIElement!
    

    override func setUpWithError() throws {
        
        try super.setUpWithError()
        app = XCUIApplication()
        countryTable = app.tables
        countrySearchBar = app.searchFields
        filterButton = app.buttons["filterButton"]
        resetFilterButton = app.buttons["resetFilterButton"]
        app.launch()

    }

    override func tearDownWithError() throws {
        
        app = nil
        countryTable = nil
        countrySearchBar = nil
        filterButton = nil
        resetFilterButton = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountryViewController_WhenViewDidLoad_RequireUIElementEnable() {

        XCTAssertTrue(filterButton.isEnabled, "The filterButton UIButton is not enable for user interaction")
        XCTAssertTrue(resetFilterButton.isEnabled, "The resertFilterButton UIbutton is not enable for user interaction")
        
    }
    
    func testCountryVeiwContoller_WhenFilterApplied_RequireDetailViewIsTopView() {
        

        filterButton.tap()
        
        let langueagePickerView = app.pickerWheels["No Languages"]
        let continentPickerWheel = app.pickerWheels["No Continents"]
        langueagePickerView.adjust(toPickerWheelValue: "English")
        continentPickerWheel.adjust(toPickerWheelValue: "Africa")
        
 
        app.buttons["filterButtonFilterView"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["🇨🇲 Cameroon"]/*[[".cells.staticTexts[\"🇨🇲 Cameroon\"]",".staticTexts[\"🇨🇲 Cameroon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        

    }

}
