//
//  ViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var firstAccess : Bool = true

    override func viewDidLoad() {
        sleep(2)
        super.viewDidLoad()
        self.movetToNextPage()
    }
    
    func movetToNextPage() {
        if(firstAccess==true) {
            print("moveTo Method Start")
            let settingStoryBoard : UIStoryboard = UIStoryboard(name: <#T##String#>, bundle: <#T##Bundle?#>)
            
        } else {
            //본 페이지로
        }
    }

    
}

