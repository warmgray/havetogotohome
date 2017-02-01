//
//  SetHomeViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit
import CoreLocation

class SettingViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var saveAndStartButton: UIButton!
    @IBOutlet weak var setHomeLabel: UILabel!
    @IBOutlet weak var dateTextField: NonEditTextField!
    @IBOutlet weak var setLimitTimeLabel: UILabel!
    
    var isFirst : Bool = false
    
    var locationManager : CLLocationManager = CLLocationManager()
    var startLocation : CLLocation!
    
    var hasLimitTime: Bool!
    var limitTime: Date!
    var homeLocation: CLLocation!
    let nsuser = UserDefaults()
    
    @IBAction func backToSetting(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 160))
        datePickerView.datePickerMode = UIDatePickerMode.time
        datePickerView.minuteInterval = 10
        
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }

    @IBAction func startButtonClick(_ sender: Any) {
        
        var homeLocString:String
        if homeLocation == nil {
            homeLocString = "37.301684,126.856570"
        } else {
            homeLocString = String(homeLocation!.coordinate.latitude) + "," + String(homeLocation!.coordinate.longitude)
        }
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm"
        
        var limitTimeString:String
        if limitTime != nil {
            limitTimeString = formater.string(from: limitTime)
        } else {
            limitTimeString = "04:00"
        }
        
        nsuser.register(defaults: ["isFirst": false, "limit_time" : limitTimeString, "home_coord" : homeLocString])
        nsuser.synchronize()
        
        UIView.animate(withDuration: 0.1, animations: {self.saveAndStartButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)}, completion: {(finish: Bool) in UIView.animate(withDuration: 0.2, animations: {self.saveAndStartButton.transform = CGAffineTransform.identity}, completion: {(finish: Bool) in self.performSegue(withIdentifier: "firstGoToMainSegue", sender: nil);})})

        //self.performSegue(withIdentifier: "firstGoToMainSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // alarm permission 맨 처음에 해야 될 것들임.
        addGestureRecognigerWithLabel()
        loadLimitTimeToolbar()
        
        let app = UIApplication.shared
        let notificationSettings = UIUserNotificationSettings()
        app.registerUserNotificationSettings(notificationSettings)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //locationManager.distanceFilter = 1000.0
        startLocation = nil
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        let latestLocation: AnyObject = locations[locations.count - 1 ]
        let latitude = String(format: "%.4f", latestLocation.coordinate.latitude)
        let longtitude = String(format: "%.4f", latestLocation.coordinate.longitude)
        var userLocation:String = latitude + "," + longtitude
        userLocation = "37.566932,126.977840"
        nsuser.register(defaults: ["user_location": userLocation])
        nsuser.synchronize()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 1000.0
        startLocation = nil
        
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH시 mm분"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    // Label에 Segue 연결하기
    func addGestureRecognigerWithLabel () {
        let homeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.setHomeSegue))
        
        setHomeLabel.addGestureRecognizer(homeGestureRecognizer)
        
    }
    
    func setHomeSegue() {
        self.performSegue(withIdentifier: "setHomeLocationSegue", sender: nil)
    }
    
    //datePicker 에서 쓰이는 toobar 설정
    func loadLimitTimeToolbar () {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolbar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolbar.barStyle = UIBarStyle.default
        
        let noLimitTimeBtn = UIBarButtonItem(title: "통금 없음", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.noLimitTimeBtn))
        
        let doneBtn = UIBarButtonItem(title: "완료", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Apple SD 산돌고딕 Neo 일반체", size: 16.0)
        
        label.text = "통금 시간"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolbar.setItems([noLimitTimeBtn,flexSpace,textBtn,flexSpace,doneBtn], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        
    }
    
    func donePressed(_ sender: UIBarButtonItem) {
        
        dateTextField.resignFirstResponder()
        
    }
    
    func noLimitTimeBtn(_ sender: UIBarButtonItem) {
        
        dateTextField.text = "통금 시간 없음"
        dateTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
