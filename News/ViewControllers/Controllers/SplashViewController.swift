//
//  SplashViewController.swift
//  News
//
//  Created by Mostafa on 8/1/19.
//  Copyright © 2019 M-M_M. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3), execute: {
            let FVC = self.storyboard?.instantiateViewController(withIdentifier: "FVC")
            self.present(FVC!, animated: true, completion: nil)
        })
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
