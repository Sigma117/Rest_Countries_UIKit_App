//
//  ViewController.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 04/06/24.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var countryTableView: UITableView!
    
    var countries: [CountryData] = []
    var filteredCountries: [CountryData] = []
    
    func sortCountries() {
        countries.sort { $0.name.common < $1.name.common }
        filteredCountries.sort { $0.name.common < $1.name.common }
        countryTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.placeholder = "Search for a country"
        
        // Setup TableView
        countryTableView.dataSource = self
        countryTableView.delegate = self
        countryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")
        
        // Fetch data
        CountryManager().fetchCountry("all") { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let data = data {
                    self.countries = data
                    self.filteredCountries = data
                    self.sortCountries()
                    self.countryTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = filteredCountries[indexPath.row]
        cell.textLabel?.text = country.name.common
        
        if let flag = country.flag {
            cell.textLabel?.text = "\(flag) \(country.name.common)"
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: "showDetailView", sender: filteredCountries[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailView",
           let detailVC = segue.destination as? DetailViewController,
           let selectedCountry = sender as? CountryData {
            detailVC.countryName = selectedCountry.name.common
        }
    }
    

    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.name.common.lowercased().contains(searchText.lowercased()) }
        }
        countryTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

