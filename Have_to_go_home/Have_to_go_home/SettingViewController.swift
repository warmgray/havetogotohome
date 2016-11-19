//
//  SetHomeViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var saveAndStartButton: UIButton!
    @IBOutlet weak var placeToGo: UILabel!
    @IBOutlet weak var timeToGo: UILabel!
    
    @IBAction func mapTrigger(_ sender: Any) {
        print("map button")
    }
    
    @IBAction func timeTrigger(_ sender: Any) {
        print("time button")
    }
    
    
    func loadSaveAndStartButton() {
        let buttonLayer = saveAndStartButton.layer
        buttonLayer.borderWidth = 1.0
        buttonLayer.cornerRadius = 21.5
        buttonLayer.masksToBounds = true
        buttonLayer.borderColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1).cgColor
    }
    
    func loadInputLabels() {
        
        let width = CGFloat(1.0)
        
        let timeBorder = CALayer()
        let placeBorder = CALayer()
        
        timeBorder.borderColor = UIColor.white.cgColor
        timeBorder.frame = CGRect(x: 0, y: timeToGo.frame.size.height - width, width: timeToGo.frame.size.width, height: timeToGo.frame.size.height)
        placeBorder.borderColor = UIColor.white.cgColor
        placeBorder.frame = CGRect(x: 0, y: placeToGo.frame.size.height - width, width: placeToGo.frame.size.width, height: placeToGo.frame.size.height)
        
        timeBorder.borderWidth = width
        timeToGo.layer.addSublayer(timeBorder)
        timeToGo.layer.masksToBounds = true
        placeBorder.borderWidth = width
        placeToGo.layer.addSublayer(placeBorder)
        placeToGo.layer.masksToBounds = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSaveAndStartButton()
        self.loadInputLabels()
    }

    

}
