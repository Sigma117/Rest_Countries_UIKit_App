//
//  FilterView.swift
//  IliadTest_iOS_UIKit
//
//  Created by Stefano Zhao on 07/06/24.
//

import Foundation
import UIKit

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var languagePickerView: UIPickerView!
    @IBOutlet var continentPickerView: UIPickerView!
    
    var selectedContinent: String?
    var selectedLanguage: String?
    
    let continents = ["No Continents","Africa", "Americas", "Asia", "Europe", "Oceania", "Polar", "Antarctic"]
    let languages = ["No Languages", "English", "French", "Spanish", "Chinese", "Arabic", "Russian", "Hindi"]
    
    override func viewDidLoad() {
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
        continentPickerView.delegate = self
        continentPickerView.dataSource = self
    }
    
    // MARK: - ContinentButtomPiker
    
    @IBAction func applyFilter(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToCountryView", sender: self)
    }
    
    // MARK: - UIPickerView DataSource and Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == languagePickerView {
             return languages.count
         } else if pickerView == continentPickerView {
             return continents.count
         }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == languagePickerView {
            return languages[row]
        } else if pickerView == continentPickerView {
            return continents[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == languagePickerView {
            selectedLanguage = (languages[row] == "No Languages") ? nil : languages[row]
        } else if pickerView == continentPickerView {
            selectedContinent = (continents[row] == "No Continents") ? nil : continents[row]
        }
    }
}
