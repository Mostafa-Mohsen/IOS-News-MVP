//
//  NetworkManager.swift
//  News
//
//  Created by Mostafa on 7/31/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    
    static var networkObserverDelegate:NetworkObserver?
    static var classServiceName:String?
    
    static func connectGetToURL(url:String ,serviceName:String ,serviceProtocol:NetworkServiceProtocol){
        
        classServiceName = serviceName
        networkObserverDelegate = (serviceProtocol as! NetworkObserver)
        
        let urlSite = URL.init(string: url)
        if let url = urlSite{
            Alamofire.request(url).validate().responseJSON(completionHandler: { response in
                if let json = response.result.value {
                    networkObserverDelegate?.handleSuccessWithJsonData(jsonData: json, serviceName: classServiceName!)

                }else if let error = response.result.error {
                    networkObserverDelegate?.handleFailWithErrorMessage(errorMessage: error.localizedDescription, serviceName: classServiceName!)
                }
            })
        }
    }
    
}
