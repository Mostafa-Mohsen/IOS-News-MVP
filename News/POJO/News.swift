//
//  News.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation
import RealmSwift
class News:Object{
    @objc dynamic var urlToImage:String = ""
    @objc dynamic var title:String = ""
    @objc dynamic var descriptions:String = ""
    @objc dynamic var author:String = ""
    @objc dynamic var date:Date = Date()
}
