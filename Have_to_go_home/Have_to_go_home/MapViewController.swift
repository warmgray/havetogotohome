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
    
    @IBOutlet weak var locationSearchBar: UINavigationBar!
    
    var resultSearchController : UISearchController? = nil
    
    let regionRadius: CLLocationDistance = 1000
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    let testlatitude : CLLocationDegrees = 37.568197
    let testlongitude : CLLocationDegrees = 126.939312
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "집 위치 설정"
        
        locationSearchBar.topItem?.titleView = resultSearchController?.searchBar
        
        locationSearchTable.tableView.contentInset = UIEdgeInsetsMake(88+UIApplication.shared.statusBarFrame.height, 0, UIApplication.shared.statusBarFrame.height, 0)
        
        definesPresentationContext = true
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = false
        
        
        locationSearchTable.mapView = mKMapViewOutlet
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }

        mKMapViewOutlet.showsUserLocation = true
        centerMapOnLocation(location: locationManager.location!)
        
        // Do any additional setup after loading the view.
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {

        let location = locations.last! as CLLocation

        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        self.mKMapViewOutlet.setRegion(region, animated: true)
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
