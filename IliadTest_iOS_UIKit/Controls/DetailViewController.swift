//
//  DetailViewController.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 07/06/24.
//

import Foundation
import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet var countryNameTitle: UILabel!
    @IBOutlet var officialNameLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var timezoneLabel: UILabel!
    @IBOutlet var unMemberLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var fetchDataIndicator: UIActivityIndicatorView!
    
    var countryName: String?
    var countryManager = CountryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let countryName = countryName {
            fetchCountryDetails(countryName: countryName)
        }
        
        fetchDataIndicator.center = self.view.center
    }
    
    func fetchCountryDetails(countryName: String) {
        fetchDataIndicator.startAnimating()
        countryManager.fetchCountry(countryName) { [weak self] data in
            guard let self = self, let country = data?.first else { return }
            DispatchQueue.main.async {
                self.fetchDataIndicator.stopAnimating()
                self.updateUI(with: country)
            }
        }
    }
    
    //MARK: Update user interface
    
    func updateUI(with country: CountryData) {
        countryNameTitle.text   = "\(country.flag ?? "⚑") \(country.name.common)"
        officialNameLabel.text  = "Country official name: \(country.name.official)"
        capitalLabel.text       = "Capital: \(country.capital?.first ?? "N/A")"
        regionLabel.text        = "Belong region: \(country.region ?? "N/A")"
        populationLabel.text    = "Country current poppulation: \(country.population ?? 0)"
        timezoneLabel.text      = "Country timezone: \(country.timezones?.joined() ?? "N/A")"
        languageLabel.text      = "Language: \(country.languages?.values.first ?? "N/A")"
        
        if let unMember = country.unMember {
            if unMember {
                unMemberLabel.text = "UN Member: Yes"
            } else {
                unMemberLabel.text = "UN Member: No"
            }
        }
        
        if let lat = country.latlng?.first, let lon = country.latlng?.last {
            centerMapKit(lat: lat, lon: lon, country: country)
        }
    }
    
    // MARK: Update MapKit
    
    func centerMapKit(lat: Double, lon: Double, country: CountryData) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = country.name.common
        mapView.addAnnotation(annotation)
        
    }
}
