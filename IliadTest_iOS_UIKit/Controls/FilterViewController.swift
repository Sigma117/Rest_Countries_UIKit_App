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
    @IBOutlet var continentButton: UIButton!
    
    var selectedContinent: String?
    var selectedLanguage: String?
    
    let continents = ["No Continents","Africa", "Americas", "Asia", "Europe", "Oceania", "Polar", "Antarctic"]
    let languages = ["No Languages", "English", "French", "Spanish", "Chinese", "Arabic", "Russian"]
    
    override func viewDidLoad() {
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
    }
    
    // MARK: - ContinentButtomPiker
    
    @IBAction func continentButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select Continent", message: nil, preferredStyle: .actionSheet)
        for continent in continents {
            alert.addAction(UIAlertAction(title: continent, style: .default, handler: { _ in
                self.selectedContinent = continent
                self.continentButton.setTitle(continent, for: .normal)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func applyFilter(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToCountryView", sender: self)
    }
    
    // MARK: - UIPickerView DataSource and Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = languages[row]
    }
}
