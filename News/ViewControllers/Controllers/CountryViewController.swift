//
//  CountryViewController.swift
//  News
//
//  Created by Mostafa on 8/1/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import UIKit
import CountryPickerView
class CountryViewController: UIViewController {

    @IBOutlet weak var countryPicker: CountryPickerView!
    
    private var countryCodePresenter:CountryCodePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.countryCodePresenter = CountryCodePresenter(countryCodeView: self)
        self.countryPicker.showPhoneCodeInView = false
        self.countryPicker.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CountryViewController: CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.countryCodePresenter.countryCodeSelected(countryCode: country.code)
    }
}
extension CountryViewController: ICountryCodeBaseView {
    func gotoNews() {
        let SVC = self.storyboard?.instantiateViewController(withIdentifier: "SVC")
        self.present(SVC!, animated: false, completion: nil)
    }
    
    
}
