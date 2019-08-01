//
//  NewsService.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation
import Alamofire

class NewsService{
    static let shared = NewsService()
    var newsPresenter:INewsPresenter?
    private init(){}
    let reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    private var pending = false
    private var page = 0
    var countryCode = ""
}

extension NewsService : INewsManager{
    func getNewsData(newsPresenter:INewsPresenter ,dataURL:String,page:Int) {
        self.newsPresenter = newsPresenter
        self.page = page
        NetworkManager.connectGetToURL(url: dataURL, serviceName: "NewsService", serviceProtocol: self)
        
        reachabilityManager?.listener = { status in
            switch status {
                
            case .reachable(.ethernetOrWiFi),.reachable(.wwan):
                print("The network is reachable over the WiFi connection")
                if self.pending {
                    NetworkManager.connectGetToURL(url: dataURL, serviceName: "NewsService", serviceProtocol: self)
                }
                
            case .unknown:
                print("unknown")
                
            case .notReachable :
                print("the network isn't reachable")

            }
        }

        // start listening
        reachabilityManager?.startListening()
    }
    
    func saveToLocal(news: [News]) {
        RealmManager.saveToRealm(news: news)
    }
}

extension NewsService : NetworkServiceProtocol,NetworkObserver{
    func handleSuccessWithJsonData(jsonData: Any, serviceName: String) {
        if serviceName == "NewsService" {
            self.pending = false
            var news:[News] = Array()
            let dict = jsonData as! [String: Any]
            let articles = dict["articles"] as! [[String: Any]]
            let totalResults = dict["totalResults"] as! Int
            for article in articles {
                let new = News()
                
                if let urlToImage = article["urlToImage"] as? String{
                    new.urlToImage = urlToImage
                }
                if let title = article["title"] as? String{
                    new.title = title
                }
                if let description = article["description"] as? String{
                    new.descriptions = description
                }
                if let author = article["author"] as? String{
                    new.author = author
                }
                news.append(new)
            }
            self.newsPresenter?.onSuccess(news: news, total: totalResults)
        }
    }
    
    func handleFailWithErrorMessage(errorMessage: String, serviceName: String) {
        if serviceName == "NewsService" {
            self.pending = true
            if errorMessage == "The Internet connection appears to be offline." && self.page == 1 {
                RealmManager.readFromRealm(serviceName: "NewsService", serviceProtocol: self)
            }else if errorMessage == "The Internet connection appears to be offline." {
                self.newsPresenter?.onFail(title: "Cellular Data is Turned Off", errorMessage: "Turn on cellular data or use Wi-Fi to access data.")
            }else{
                self.newsPresenter?.onFail(title: "Error", errorMessage: errorMessage)
            }
        }
    }
}

extension NewsService: RealmServiceProtocol,Realmobserver{
    func handleSuccessWithRealm(serviceName: String, news: [News]) {
        if serviceName == "NewsService" {
            var arr:[News] = Array()
            for new in news {
                arr.append(new)
            }
            self.newsPresenter?.onRealmSuccess(news: arr)
        }
    }
    
}

