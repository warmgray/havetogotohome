//
//  LimitTimeSettingViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class LimitTimeSettingViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var setLimitTime: UIButton!
    @IBOutlet weak var noLimitTime: UIButton!
    
    var hasLimitTime: Bool!
    var limitTime: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBottomButton()
        loadTopButton()
        timePicker.setValue(UIColor.white, forKeyPath: "textColor" )
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTopButton () {
        let buttonLayer = setLimitTime.layer
        buttonLayer.borderWidth = 1.0
        buttonLayer.cornerRadius = 5
        buttonLayer.masksToBounds = true
        buttonLayer.borderColor = UIColor(red: 62/255, green: 163/255, blue: 253/255, alpha: 1).cgColor
    }
    
    func loadBottomButton () {
        let buttonLayer = noLimitTime.layer
        buttonLayer.borderWidth = 1.0
        buttonLayer.cornerRadius = 5
        buttonLayer.masksToBounds = true
        buttonLayer.borderColor = UIColor(red: 246/255, green: 121/255, blue: 119/255, alpha: 1).cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
