//
//  RealmManager.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager{
    static var realmObserverDelegate:Realmobserver?
    static var classServiceName:String?
    
    static func saveToRealm(news:[News]){
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            for new in news {
                new.date = Date()
                realm.add(news)
            }
        }
    }
    
    static func readFromRealm(serviceName:String ,serviceProtocol:RealmServiceProtocol){
        classServiceName = serviceName
        realmObserverDelegate = (serviceProtocol as! Realmobserver)
        let realm = try! Realm()
        let results = realm.objects(News.self).sorted(byKeyPath: "date")
        if results.count > 0 {
            realmObserverDelegate?.handleSuccessWithRealm(serviceName: classServiceName!, news: Array(results))
        }else {
            realmObserverDelegate?.handleSuccessWithRealm(serviceName: classServiceName!, news: [])
        }
    }
}
