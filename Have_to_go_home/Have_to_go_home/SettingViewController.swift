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
    @IBOutlet weak var setLimitTimeLabel: UILabel!
    
    var isFirst : Bool = false
    
    var locationManager : CLLocationManager = CLLocationManager()
    var startLocation : CLLocation!
    
    var hasLimitTime: Bool!
    var limitTime: Date!
    var homeLocation: CLLocation!
    let nsuser = UserDefaults()

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
    
    
    // Label에 Segue 연결하기
    func addGestureRecognigerWithLabel () {
        let homeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.setHomeSegue))
        let timeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.setLimitTimeSegue))
        
        setHomeLabel.addGestureRecognizer(homeGestureRecognizer)
        setLimitTimeLabel.addGestureRecognizer(timeGestureRecognizer)
    }
    
    func setHomeSegue() {
        self.performSegue(withIdentifier: "setHomeLocationSegue", sender: nil)
    }
    
    func setLimitTimeSegue() {
        self.performSegue(withIdentifier: "setLimitTimeSegue", sender: nil)
    }

    

}
