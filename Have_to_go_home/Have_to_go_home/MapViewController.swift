//
//  MapViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mKMapViewOutlet: MKMapView!
    @IBAction func DoneAction(_ sender: Any) {
        performSegue(withIdentifier: "homeSetDone", sender: nil)
    }
    
    @IBAction func backToSetting1(_ sender: Any) {
        performSegue(withIdentifier: "backToSetting1", sender: nil)
    }
    
    
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    let testlatitude : CLLocationDegrees = 37.568197
    let testlongitude : CLLocationDegrees = 126.939312
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        centerMapOnLocation(location: CLLocation(latitude: latitude, longitude: longitude))

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "homeSetDone") {
            let location:CLLocation = CLLocation(latitude: testlatitude, longitude: testlongitude)
            let locationString:String = String(describing: location)
            (segue.destination as! SettingViewController).homeLocation = location
            (segue.destination as! SettingViewController).placeToGo.text = locationString
            
            
        } else if(segue.identifier == "back") {
            
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mKMapViewOutlet.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        latitude = locValue.latitude
        longitude = locValue.longitude
    }
    
}
