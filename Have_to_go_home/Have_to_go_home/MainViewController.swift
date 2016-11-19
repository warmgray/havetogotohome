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
        drawPathCircle(transportNum: 2, start: 4, percentage: 25)
        drawPathCircle(transportNum: 5, start: 33, percentage: 20)
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
    
    
    
    func drawPathCircle (transportNum: Int, start:Float, percentage:Float) {
        let circleProgress: DrawMainGraphic = DrawMainGraphic(frame: self.view.bounds)
        let startCgFloat = CGFloat(start)
        let perCgFloat = CGFloat(percentage)
        circleProgress.trackWidth = 6
        circleProgress.color = getColorOfPath(transportNum: transportNum)
        circleProgress.startPoint = startCgFloat
        circleProgress.fillPercentage = perCgFloat
        
        self.view.addSubview(circleProgress)
    }
    
    func getColorOfPath (transportNum: Int) -> UIColor {
        var resultColor:UIColor!
        
        let modNum = transportNum % 10
        switch modNum {
        
        case 1:
            resultColor = UIColor(red: 0/255, green: 73/255, blue: 139/255, alpha: 1)
        case 2:
            resultColor = UIColor(red: 0, green: 146/255, blue: 70/255, alpha: 1)
        case 3:
            resultColor = UIColor(red: 243/255, green: 102/255, blue: 48/255, alpha: 1)
        case 4:
            resultColor = UIColor(red: 0, green: 162/255, blue: 209/255, alpha: 1)
        case 5:
            resultColor = UIColor(red: 142/255, green: 128/255, blue: 75/255, alpha: 1)
        case 6:
            resultColor = UIColor(red: 158/255, green: 69/255, blue: 16/255, alpha: 1)
        case 7:
            resultColor = UIColor(red: 93/255, green: 102/255, blue: 25/255, alpha: 1)
        case 8:
            resultColor = UIColor(red: 214/255, green: 64/255, blue: 106/255, alpha: 1)
        case 9:
            resultColor = UIColor(red: 142/255, green: 118/255, blue: 75/255, alpha: 1)
        default:
            resultColor = UIColor(red: 52/255, green: 86/255, blue: 250/255, alpha: 1)
        }
        
        return resultColor
    }
    
}

