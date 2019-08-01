//
//  NetworkObserver.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation

protocol NetworkObserver {
    func handleSuccessWithJsonData(jsonData:Any ,serviceName:String)
    func handleFailWithErrorMessage(errorMessage:String , serviceName:String)
}
