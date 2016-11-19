//
//  ViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet var mainMessage: UILabel!
    @IBOutlet var timer: UILabel!
    @IBOutlet weak var timeLimitMessage: UILabel!
    
    @IBOutlet weak var missionHeader: UILabel!
    @IBOutlet weak var transportation: UILabel!
    @IBOutlet weak var missionTail: UILabel!
    
    @IBOutlet weak var wayInfoMessage: UILabel!
    @IBOutlet weak var transportationArrivalTime: UILabel!
    
    @IBOutlet weak var bottomButtonMessage: UIButton!
    @IBOutlet weak var baseDotCircle: UIImageView!
    
    var circleCenter:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBottomButton()
        loadArrivalTimeLabel()
        drawPathCircle()
        print(baseDotCircle.bounds)
    }
    
    func loadBottomButton () {
        let buttonLayer = bottomButtonMessage.layer
        buttonLayer.borderWidth = 1.0
        buttonLayer.cornerRadius = 5
        buttonLayer.masksToBounds = true
        buttonLayer.borderColor = UIColor(red: 62/255, green: 163/255, blue: 253/255, alpha: 1).cgColor
    }
    
    func loadArrivalTimeLabel () {
        let buttonLayer = transportationArrivalTime.layer
        buttonLayer.cornerRadius = 6
        buttonLayer.masksToBounds = true
        buttonLayer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        transportationArrivalTime.textColor = UIColor.black
    }
    
    
    
    func drawPathCircle () {
        var circleProgress: DrawMainGraphic = DrawMainGraphic(frame: self.view.bounds)
        circleProgress.trackWidth = 5
        
        circleProgress.startPoint = 0
        circleProgress.fillPercentage = 50
        
        self.view.addSubview(circleProgress)
    }
    
}

