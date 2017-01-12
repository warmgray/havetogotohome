//
//  MapViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
import GooglePlacePicker
import GoogleMaps

class NewMapViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var user_latitude: Double?
    var user_longtitude: Double?
    
    var first_location_update:Bool = true
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        let latestLocation: AnyObject = locations[locations.count - 1 ]
        user_latitude = latestLocation.coordinate.latitude
        user_longtitude = latestLocation.coordinate.longitude
        if first_location_update {
            let center = CLLocationCoordinate2D(latitude: user_latitude!, longitude: user_longtitude!)
            let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.002, longitude: center.longitude + 0.002)
            let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.002, longitude: center.longitude - 0.002)
            let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
            let config = GMSPlacePickerConfig(viewport: viewport)
            let placePicker = GMSPlacePicker(config: config)
            
            placePicker.pickPlace(callback: {(place, error) -> Void in
                if let error = error {
                    print("Pick Place error: \(error.localizedDescription)")
                    return
                }
                
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                } else {
                    self.nameLabel.text = "No place selected"
                    self.addressLabel.text = ""
                }
            })
            first_location_update = false
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 1000.0
        
    }
    
    
    @IBAction func getCurrentPlace(_ sender: UIButton) {
        let center = CLLocationCoordinate2D(latitude: user_latitude!, longitude: user_longtitude!)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.01, longitude: center.longitude + 0.01)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.01, longitude: center.longitude - 0.01)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                self.nameLabel.text = place.name
                self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                    .joined(separator: "\n")
            } else {
                self.nameLabel.text = "No place selected"
                self.addressLabel.text = ""
            }
        })
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
        placesClient = GMSPlacesClient.shared()
        let camera = GMSCameraPosition.camera(withLatitude: 30.0,
                                              longitude: 30.0,
                                              zoom: zoomLevel)
        
        let testFrame = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: 20)
        print("testFrame")
        print(testFrame.size)

        mapView = GMSMapView.map(withFrame: testFrame, camera: camera)
        //mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        //mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autoresizesSubviews = false
        // Add the map to the view, hide it until we've got a location update.
        view.insertSubview(mapView, at: 0)
        //view.addSubview(mapView)
        //mapView.isHidden = true
        
        
    }
    
    
    @IBAction func DoneAction(_ sender: Any) {
        performSegue(withIdentifier: "homeSetDone", sender: nil)
    }
    
    @IBAction func backToSetting1(_ sender: Any) {
        performSegue(withIdentifier: "backToSetting1", sender: nil)
    }
    
    
    
}
