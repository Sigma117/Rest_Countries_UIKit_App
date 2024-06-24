//
//  CountryViewControllerTests.swift
//  Rest_Countries_UIKit_AppTests
//
//  Created by Stefano Zhao on 20/06/24.
//

import XCTest
@testable import Rest_Countries_UIKit_App

final class CountryViewControllerTests: XCTestCase {
    
    var sut: CountryViewController!
    var navigationController: UINavigationController!

    override func setUpWithError() throws {
        // Step 1: Create an istance of storyboard
        sut = CountryViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Step 2: Instance UIViewController with StoryBoard ID
        sut = storyboard.instantiateViewController(withIdentifier: "CountryViewController") as? CountryViewController
        
        // Step 3: Make the view controller execute
        sut.loadViewIfNeeded()
        navigationController = UINavigationController(rootViewController: sut)
        
        
        
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
    }

    func testNavigationStackInCountryViewControl_WhenFilterButtonTapped_FilterViewControllerPushed() {
        
        let myPredicate = NSPredicate { input, _ in
            return ( input as? UINavigationController)?.topViewController is FilterViewController
        }
        
        expectation(for: myPredicate, evaluatedWith: navigationController)
        
        sut.filterButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 2)

    }
    
    func testNavigationStackInCountryViewControl_WhenTableViewTapped_DetailViewControllerPushed() {
        
        // Create a sample index path for the first row in the table view's first section
        let indexPath = IndexPath(row: 0, section: 0)
        
        // Give time for fetch data
        RunLoop.current.run(until: Date() + 5)
        
        // Simulate the selection of the cell at the given index path
        sut.countryTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        sut.tableView(sut.countryTableView, didSelectRowAt: indexPath)
        
        // Give time for switch view
        RunLoop.current.run(until: Date())
        
        guard let _ = navigationController.topViewController as? DetailViewController else {
            XCTFail()
            return
        }
    }
}
