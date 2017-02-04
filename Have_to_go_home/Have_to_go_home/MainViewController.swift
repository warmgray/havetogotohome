//
//  ViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet var timer: UILabel!
    @IBOutlet weak var timeLimitMessage: UILabel!
    @IBOutlet weak var twoPoint: UILabel!
    
    @IBOutlet weak var wayInfoMessage: UILabel!
    @IBOutlet weak var transportationArrivalTime: UILabel!
    
    @IBOutlet weak var workPathButton: UIButton!
    @IBOutlet weak var baseDotCircle: UIImageView!
    
    @IBOutlet weak var reSetting: UIButton!
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var missionDetailView: UIView!
    
    //constraints
    @IBOutlet weak var speechBubbleConstraint: NSLayoutConstraint!
    @IBOutlet weak var pathButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var timerCenterHeight: NSLayoutConstraint!
    @IBOutlet weak var missionNameWidth: NSLayoutConstraint!
    @IBOutlet weak var missionNameTopSpace: NSLayoutConstraint!
    @IBOutlet weak var arrowWidth: NSLayoutConstraint!
    @IBOutlet weak var topButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var topLineTopSpace: NSLayoutConstraint!
    
    
    var circleCenter:CGPoint!
    var homeLocation:String?
    var limitTime:String?
    var userLocation:String?
    var lastTime:String?
    var leftTime:Date?
    
    var radius:CGFloat!
    
    var dotShow:Bool = true
    
    var circlePath:Array<circleValue> = []
    var currentRoute:Dictionary<String,String> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nsuser = UserDefaults()
        homeLocation = nsuser.object(forKey: "home_coord") as! String?
        limitTime = nsuser.object(forKey: "limit_time") as! String?
        userLocation = nsuser.object(forKey: "user_location") as! String?
        
        let parser = loadToHomeParser(arr:"", usr:"37.523657,126.925234", home:homeLocation!) // 이후 컨트롤러 넘기기
        let result = nsuser.object(forKey: "result") as! String?
        if result == "false" {

            self.performSegue(withIdentifier: "reSettingSegue",sender: nil)
        }
        currentRoute = parser.getCurrentRoute()
        circlePath = parser.getCircleValueArray()
        lastTime = nsuser.object(forKey: "first_start_time") as! String?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let initTime = dateFormatter.date(from: parser.datalist.object(forKey: "first_start_time") as! String)
        dateFormatter.dateFormat = "HH   mm"
        let lastTimeString = dateFormatter.string(from: initTime!)
        timer.text = lastTimeString
        
        setConstraints()
        setLableBorder()
        
        loadArrivalTimeLabel()
        countDownTimer()
        
    }
    
    @IBAction func backToMain (sender: UIStoryboardSegue) {
        
    }

    override func viewDidAppear(_ animated: Bool) {
        drawPath(circleValueArray: circlePath)
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(flickingTwoDots), userInfo: nil, repeats: true)
        var _ = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
    }
    
    func loadArrivalTimeLabel () {
        let buttonLayer = transportationArrivalTime.layer
        buttonLayer.cornerRadius = 6
        buttonLayer.masksToBounds = true
        buttonLayer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor

        transportationArrivalTime.textColor = UIColor.black
    }
    
    func flickingTwoDots () {
        if dotShow {
            twoPoint.alpha = 0.5
            dotShow = false
        } else {
            twoPoint.alpha = 1
            dotShow = true
        }
    }
    
    func drawBaseLine () {
        
    }
    
    func countDownTimer () {
        let parser = loadToHomeParser(arr:"", usr:"37.523657,126.925234", home:homeLocation!)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let initTime = dateFormatter.date(from: parser.datalist.object(forKey: "first_start_time") as! String)
        let initTimeInt = initTime?.timeIntervalSince1970
        let now = NSDate().timeIntervalSince1970
        let diffSeconds = Int(initTimeInt! - now)
        let hour:Int = diffSeconds / 3600
        let min:Int = (diffSeconds - 3600 * hour) / 60

        timeLimitMessage.text = "\(hour)시간 \(min)분 남았어요"
    }


    
    func drawPathCircle (trafficInfo:String, color:String, start:Float, percentage:Float) {
        let circleProgress: DrawMainGraphic = DrawMainGraphic(frame: self.view.bounds)
        let startCgFloat = CGFloat(start)
        let perCgFloat = CGFloat(percentage)
        let radius = CGFloat(self.baseDotCircle.layer.frame.width/2+2)
        let centerPoint = CGPoint(x: self.baseDotCircle.layer.frame.midX, y: self.baseDotCircle.layer.frame.midY + radius*5/44)
        
        circleProgress.trackWidth = radius/20
        circleProgress.color = color.hexColor
        circleProgress.startPoint = startCgFloat
        circleProgress.fillPercentage = perCgFloat
        circleProgress.trafficInfo = trafficInfo
        self.view.insertSubview(circleProgress, aboveSubview: baseDotCircle)
        circleProgress.makeCircleCALayer(dotCircleCenter: centerPoint,radius: radius)
        circleProgress.animateCircle(duration: 0.7)
    }
    
    func drawPath (circleValueArray:Array<circleValue>) {
        var currentPoint:Float = 0.0
        
        for var index in 0..<circleValueArray.count {
            let circleValue:circleValue = circleValueArray[index]
            if circleValue.color == "" {
            } else {
                drawPathCircle(trafficInfo:circleValue.trafficNum, color: circleValue.color, start: currentPoint, percentage: Float(circleValue.portion))
            }
            currentPoint += Float(circleValue.portion)
            
        }
    }
    
    func setConstraints () {
        speechBubbleConstraint.constant = CGFloat(self.baseDotCircle.layer.frame.width/7)
        
        timer.adjustsFontSizeToFitWidth = true
        timer.minimumScaleFactor = 0.6
        timeLimitMessage.adjustsFontSizeToFitWidth = true
        timeLimitMessage.minimumScaleFactor = 0.6
        
        twoPoint.adjustsFontSizeToFitWidth = true
        twoPoint.minimumScaleFactor = 0.6
        
        missionName.adjustsFontSizeToFitWidth = true
        missionName.minimumScaleFactor = 0.6
        
        timerCenterHeight.constant = (120 - self.view.frame.width)/2
        pathButtonWidth.constant = self.view.frame.width*3/7
        missionNameWidth.constant = self.view.frame.width*2/7
        
        arrowWidth.constant = missionDetailView.layer.frame.width/14
        
        topButtonWidth.constant = missionDetailView.layer.frame.width/15
        topLineTopSpace.constant = missionDetailView.layer.frame.height/40
        missionNameTopSpace.constant = missionDetailView.layer.frame.height/15
        
    }
    
    func setLableBorder () {
        
        missionName.layer.borderColor = UIColor.black.cgColor
        missionName.layer.borderWidth = 1
        missionName.layer.cornerRadius = missionName.layer.frame.height/2-2
        
        missionDetailView.layer.cornerRadius = 10
        
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

