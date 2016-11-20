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
    @IBOutlet weak var placeToGo: UILabel!
    @IBOutlet weak var timeToGo: UILabel!
    
    var isFirst : Bool = false
    
    var locationManager : CLLocationManager = CLLocationManager()
    var startLocation : CLLocation!
    
    var hasLimitTime: Bool!
    var limitTime: Date!
    var homeLocation: CLLocation!
    let nsuser = UserDefaults()
    
    @IBAction func setHomeSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "setHomeSegue", sender: nil)
    }
    
    @IBAction func setLimitTimeSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "setLimitTimeSegue", sender: nil)
    }

    @IBAction func startButtonClick(_ sender: Any) {
        let clickButton = saveAndStartButton.layer
        clickButton.backgroundColor = UIColor.white.cgColor
        saveAndStartButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        var homeLocString:String
        if homeLocation == nil {
            homeLocString = "37.566932,126.977840"
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

        self.performSegue(withIdentifier: "firstGoToMainSegue", sender: nil)
    }
    
    
    
    func loadSaveAndStartButton() {
        let buttonLayer = saveAndStartButton.layer
        buttonLayer.borderWidth = 1.0
        buttonLayer.cornerRadius = 21.5
        buttonLayer.masksToBounds = true
        buttonLayer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
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
        // alarm permission 맨 처음에 해야 될 것들임.
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
        if(segue.identifier == "setHomeSegue") {
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        print(33)
        let latestLocation: AnyObject = locations[locations.count - 1 ]
        let latitude = String(format: "%.4f", latestLocation.coordinate.latitude)
        print(latitude)
        let longtitude = String(format: "%.4f", latestLocation.coordinate.longitude)
        var userLocation:String = latitude + "," + longtitude
        print(userLocation)
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

    

}
