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
    
    func loadSaveAndStartButton() {
        saveAndStartButton.layer.borderWidth = 1.0
        saveAndStartButton.layer.borderColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1).cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSaveAndStartButton()
       
    }

    

}
