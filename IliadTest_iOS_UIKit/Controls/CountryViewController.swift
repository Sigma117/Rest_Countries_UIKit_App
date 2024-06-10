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
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var resetFilterButton: UIButton!
    @IBOutlet var fetchDataIndicator: UIActivityIndicatorView!
    
    var countries: [CountryData] = []
    var filteredCountries: [CountryData] = []
    var selectedContinent: String?
    var selectedLanguage: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.placeholder = "Search for a country"
        
        // Setup TableView
        countryTableView.dataSource = self
        countryTableView.delegate = self
        countryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")
        
        // Setup Activity Indicator
        fetchDataIndicator.center = self.view.center
        
        fetchData("all")

    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = filteredCountries[indexPath.row]
        cell.textLabel?.text = country.name.common
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
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
    
    // MARK: - Unwind and filters
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        // Perform another fetch request becase in the first one we fetch only names & flags, this time we fetch names, flags, regions, languages.
        fetchData("filter")
        performSegue(withIdentifier: "showFilterView", sender: self)
    }
    
    
    @IBAction func unwindToCountryView(_ unwindSegue: UIStoryboardSegue) {
        print("tornato indietro nella countryview")
        if let filterVC = unwindSegue.source as? FilterViewController {
            selectedContinent = filterVC.selectedContinent
            selectedLanguage = filterVC.selectedLanguage
            print("Selected Continent: \(selectedContinent ?? "None")")
            print("Selected Language: \(selectedLanguage ?? "None")")
            if (selectedContinent != nil) || (selectedLanguage != nil) {
                applyFilters()
            } else {
                print("no filter selected")
                filteredCountries = countries
                countryTableView.reloadData()
            }
        }
    }
    
    
    @IBAction func resetFilterButtonTapped(_ sender: Any) {
        resetFilters()
    }
    
    func sortCountries() {
        countries.sort { $0.name.common < $1.name.common }
        filteredCountries.sort { $0.name.common < $1.name.common }
        countryTableView.reloadData()
    }
    
    func resetFilters() {
        selectedContinent = nil
        selectedLanguage = nil
        searchBar.text = ""
        filteredCountries = countries
        countryTableView.reloadData()
    }
    
    func applyFilters() {
        filteredCountries = countries
        
        if let continent = selectedContinent {
            filteredCountries = filteredCountries.filter { $0.region == continent }
        }
        
        if let language = selectedLanguage {
            filteredCountries = filteredCountries.filter { country in
                country.languages?.contains { $0.value == language } ?? false
            }
        }
        DispatchQueue.main.async {
            self.countryTableView.reloadData()
        }
    }
    
    // MARK: - Fetch request
    func fetchData(_ type: String) {
        fetchDataIndicator.startAnimating()
        CountryManager().fetchCountry(type) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.fetchDataIndicator.stopAnimating()
                if let data = data {
                    self.countries = data
                    self.filteredCountries = data
                    self.sortCountries()
                    self.countryTableView.reloadData()
                }
            }
        }
    }
}

