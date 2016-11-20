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
        
        let nsuser = UserDefaults()
        nsuser.register(defaults: ["isFirst": false])
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
        let parser = loadToHomeParser(arr:"11:00", usr:"37.521911,126.924314", home:"37.292070,126.854641")
        parser.getDataList()
        print(parser.datalist)
        
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
        locationManager.distanceFilter = 1000.0
        startLocation = nil
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "setHomeSegue") {
            
        }
    }
    
    
    
    func isFirstUser () {
        if(!isFirst) {
            self.performSegue(withIdentifier: "firstGoToMainSegue", sender: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        let latestLocation: AnyObject = locations[locations.count - 1 ]
        var latitude = String(format: "%.4f", startLocation.coordinate.latitude)
        var longtitude = String(format: "%.4f", startLocation.coordinate.longitude)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 1000.0
        startLocation = nil
        
    }

    

}
