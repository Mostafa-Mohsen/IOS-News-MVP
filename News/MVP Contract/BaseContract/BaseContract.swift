//
//  BaseContract.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation

protocol IBaseView {
    func showLoading()
    func hideLoading()
    func showErrorMessage(title:String ,errorMessage: String)
}

protocol ICountryCodeBaseView {
    func gotoNews()
}
