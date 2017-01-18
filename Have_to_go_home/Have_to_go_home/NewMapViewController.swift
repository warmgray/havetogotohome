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

class NewMapViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate  {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var marker: GMSMarker!
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
            let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.0005, longitude: center.longitude + 0.0005)
            let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.0005, longitude: center.longitude - 0.0005)
            let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
            let config = GMSPlacePickerConfig(viewport: viewport)
            

            let camera = GMSCameraPosition.camera(withLatitude: user_latitude!,
                                                  longitude: user_longtitude!,
                                                  zoom: zoomLevel)
            // frame size change
            let testFrame = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: 20)
            print("testFrame")
            print(testFrame.size)
            //mapView = GMSMapView.map(withFrame: testFrame, camera: camera)
            
            mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
            mapView.delegate = self
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.autoresizesSubviews = false
            let position = CLLocationCoordinate2DMake(CLLocationDegrees(user_latitude!
            ), CLLocationDegrees(user_longtitude!))
            marker = GMSMarker(position: position)
            
            placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
                if let error = error {
                    print("Pick Place error: \(error.localizedDescription)")
                    return
                }
                if let placeLikelihoodList = placeLikelihoodList {
                    self.marker.title = "\(placeLikelihoodList.likelihoods[0].place.name)"
                }
            })
            
            
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.map = mapView
            self.view = mapView
            
            //view.insertSubview(mapView, at: 0)
            //self.view.addSubview(mapView)
            //mapView.isHidden = true
            first_location_update = false
        }
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.clear()
        print("move move")
    }
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        marker.position = mapView.camera.target
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
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
        
        
        //var mapInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 300.0)
        //mapView.padding = mapInsets
        // Add the map to the view, hide it until we've got a location update.
        
        
        
        
        
    }
    
    
    @IBAction func DoneAction(_ sender: Any) {
        performSegue(withIdentifier: "homeSetDone", sender: nil)
    }
    
    @IBAction func backToSetting1() {
        performSegue(withIdentifier: "backToSetting1", sender: nil)
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
    
    
}
