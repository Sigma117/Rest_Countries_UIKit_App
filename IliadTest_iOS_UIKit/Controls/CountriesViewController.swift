//
//  ViewController.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 04/06/24.
//

import UIKit

class CountriesViewController: UIViewController {

    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var countryTableView: UITableView!
    
    var countryManager = CountryManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        countryManager.fetchCountry("italy")
        // Do any additional setup after loading the view.
    }


}

