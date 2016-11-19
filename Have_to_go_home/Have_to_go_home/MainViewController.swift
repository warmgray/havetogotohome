//
//  ViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        sleep(2)
        super.viewDidLoad()
        _ = Timer.init(timeInterval: 1.0, target: self, selector: #selector(movetToNextPage), userInfo: nil, repeats: false)
    }
    
    func movetToNextPage() {
        self.performSegue(withIdentifier: "goToFirstSetting", sender: self)
    }

    
}

