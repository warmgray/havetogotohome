//
//  MapViewController.swift
//  Have_to_go_home
//
//  Created by 유정우 on 2016. 11. 19..
//  Copyright © 2016년 유정우. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UISearchControllerDelegate {
    
    @IBAction func backToSetting1(_ sender: Any) {
        
    }
    
    @IBOutlet weak var locationSearchBar: UINavigationBar!
    @IBOutlet weak var GMSView: UIView!
    
    var resultSearchController : UISearchController? = nil
    
    let regionRadius: CLLocationDistance = 1000
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    let testlatitude : CLLocationDegrees = 37.568197
    let testlongitude : CLLocationDegrees = 126.939312
    
    var user_latitude: Double?
    var user_longtitude: Double?
    
    var mapView: GMSMapView!
    var marker: GMSMarker!
    var placesClient: GMSPlacesClient!
    
    var zoomLevel: Float = 15.0
    var first_location_update:Bool = true
    
    var tableDataSource: GMSAutocompleteTableDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "장소명으로 검색"
        
        locationSearchTable.tableView.contentInset = UIEdgeInsetsMake(88+UIApplication.shared.statusBarFrame.height, 0, UIApplication.shared.statusBarFrame.height, 0)
        locationSearchBar.topItem?.titleView = resultSearchController?.searchBar
        
        definesPresentationContext = true
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
            
        placesClient = GMSPlacesClient.shared()
        
        // Do any additional setup after loading the view.
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
    
    func didUpdateAutocompletePredictionsForTableDataSource(tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator off.
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        // Reload table data.
        resultSearchController?.searchResultsController?.reloadInputViews()
        
    }
    
    func didRequestAutocompletePredictionsForTableDataSource(tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator on.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // Reload table data.
        resultSearchController?.searchResultsController?.reloadInputViews()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {

        let latestLocation: AnyObject = locations[locations.count - 1 ]
        user_latitude = latestLocation.coordinate.latitude
        user_longtitude = latestLocation.coordinate.longitude
        if first_location_update {
            let center = CLLocationCoordinate2D(latitude: user_latitude!, longitude: user_longtitude!)
            let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.0005, longitude: center.longitude + 0.0005)
            let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.0005, longitude: center.longitude - 0.0005)
            let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
            _ = GMSPlacePickerConfig(viewport: viewport)
            
            
            let camera = GMSCameraPosition.camera(withLatitude: user_latitude!,
                                                  longitude: user_longtitude!,
                                                  zoom: zoomLevel)
            mapView = GMSMapView.map(withFrame: GMSView.bounds, camera: camera)
            mapView.delegate = self
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = false
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
            self.GMSView.addSubview(mapView)
            
            first_location_update = false
        }
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
        
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        latitude = locValue.latitude
//        longitude = locValue.longitude
//    }
    
}

extension MapViewController: GMSAutocompleteTableDataSourceDelegate {
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        
        resultSearchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
    }
    
    func searchController(controller: UISearchController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        tableDataSource?.sourceTextHasChanged(searchString)
        return false
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // TODO: Handle the error.
        print("Error: \(error.localizedDescription)")
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
}
