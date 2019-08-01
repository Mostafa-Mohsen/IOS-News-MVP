//
//  NewsContract.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation

protocol INewsView : IBaseView {
    func renderNewsWithObjects(news:[News])
    func resetNews()
    func openDialogDetails(new:News)
    func setCountryCode(countryCode:String)
}

protocol INewsPresenter {
    func getNews(refresh:Bool)
    func onSuccess(news: [News],total: Int)
    func onFail(title:String ,errorMessage: String)
    func onRealmSuccess(news: [News])
    func openDialogDetails(new:News)
    func setCountryCode(countryCode:String)
    func getCountryCode()
}

protocol ICountryCodePresenter {
    func countryCodeSelected(countryCode:String)
}

protocol INewsManager {
    func getNewsData(newsPresenter:INewsPresenter ,dataURL:String,page:Int)
    func saveToLocal(news:[News])
}
