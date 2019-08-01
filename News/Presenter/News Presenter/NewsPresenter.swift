//
//  NewsPresenter.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation

class NewsPresenter {
    let newsView:INewsView
    
    init(newsView:INewsView) {
        self.newsView = newsView
    }
    
    private var page = 1
    private var totalResults = 1
    private var title = ""
    private var refreshing = false
    private var countryCode = ""
    private var fromRealm = false
    
    func saveToRealm(news: [News]){
        var arr:[News] = Array()
        if news.count > 5 {
            for new in news[0...4] {
                arr.append(new)
            }
        } else {
            for new in news {
                arr.append(new)
            }
        }
         NewsService.shared.saveToLocal(news: arr)
    }
}

extension NewsPresenter : INewsPresenter{
    
    
    func getNews(refresh:Bool) {
        self.newsView.showLoading()
        self.refreshing = refresh
        if self.refreshing {
            NewsService.shared.getNewsData(newsPresenter: self, dataURL: "https://newsapi.org/v2/top-headlines?country=\(self.countryCode)&page=1&pageSize=10&apiKey=99a9456587384c1a89bcd3a060a6b89c", page: 1)
        }else{
            if self.page*10 < totalResults+10 {
                NewsService.shared.getNewsData(newsPresenter: self, dataURL: "https://newsapi.org/v2/top-headlines?country=\(self.countryCode)&page=\(self.page)&pageSize=10&apiKey=99a9456587384c1a89bcd3a060a6b89c", page: self.page)
            }
        }
    }
    
    func onSuccess(news: [News],total: Int) {
        self.newsView.hideLoading()
        if self.refreshing && !self.fromRealm {
            self.refreshing = false
            if self.title != news[0].title {
                self.title = news[0].title
                self.newsView.resetNews()
                self.newsView.renderNewsWithObjects(news: news)
                self.saveToRealm(news: news)
                self.page = 2
            }
        }else{
            self.fromRealm = false
            self.page += 1
            if page == 2 {
                totalResults = total
                if totalResults == 0 {
                    self.page = 1
                    self.totalResults = 1
                    self.countryCode = "us"
                    self.getNews(refresh: false)
                }else{
                    self.title = news[0].title
                    self.newsView.resetNews()
                    self.saveToRealm(news: news)
                }
            }
            self.newsView.renderNewsWithObjects(news: news)
        }
    }
    
    func onFail(title:String ,errorMessage: String) {
        self.newsView.hideLoading()
        self.newsView.showErrorMessage(title: title, errorMessage: errorMessage)
    }
    
    func onRealmSuccess(news: [News]) {
        self.fromRealm = true
        self.page = 1
        self.newsView.hideLoading()
        self.newsView.resetNews()
        self.newsView.renderNewsWithObjects(news: news)
        self.newsView.showErrorMessage(title: "Cellular Data is Turned Off", errorMessage: "Turn on cellular data or use Wi-Fi to access data.")
    }
    
    func openDialogDetails(new:News) {
        self.newsView.openDialogDetails(new:new)
    }
    
    func setCountryCode(countryCode:String){
        self.countryCode = countryCode
        self.page = 1
    }
    
    func getCountryCode(){
        self.countryCode = NewsService.shared.countryCode
        self.newsView.setCountryCode(countryCode: self.countryCode)
    }
    
}
