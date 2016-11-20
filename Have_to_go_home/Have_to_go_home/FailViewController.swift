//
//  FailViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 20..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class FailViewController: UIViewController {

    
    @IBOutlet weak var butGoHome: UIButton!
    @IBOutlet weak var noFuture: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTopButton () {
        let buttonLayer = butGoHome.layer
        buttonLayer.borderWidth = 1.0
        buttonLayer.cornerRadius = 5
        buttonLayer.masksToBounds = true
        buttonLayer.borderColor = UIColor(red: 24/255, green: 133/255, blue: 255/255, alpha: 1).cgColor
    }
    
    func loadBottomButton () {
        let buttonLayer = noFuture.layer
        buttonLayer.borderWidth = 1.0
        buttonLayer.cornerRadius = 5
        buttonLayer.masksToBounds = true
        buttonLayer.borderColor = UIColor(red: 255/255, green: 115/255, blue: 140/255, alpha: 1).cgColor
    }

}
