//
//  CountryCodePresenter.swift
//  News
//
//  Created by Mostafa on 8/1/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation

class CountryCodePresenter {
    let countryCodeView:ICountryCodeBaseView
    
    init(countryCodeView:ICountryCodeBaseView) {
        self.countryCodeView = countryCodeView
    }
}

extension CountryCodePresenter : ICountryCodePresenter {
    func countryCodeSelected(countryCode: String) {
        NewsService.shared.countryCode = countryCode
        self.countryCodeView.gotoNews()
    }
}
