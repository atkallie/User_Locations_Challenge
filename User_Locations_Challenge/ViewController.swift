//
//  ViewController.swift
//  User_Locations_Challenge
//
//  Created by Ahmed T Khalil on 1/14/17.
//  Copyright © 2017 kalikans. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    //it's a series of logical steps
    
    //To obtain the user's location for the coordinates...
    //first you have to define a location manager...
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //specify what is being updated based on location
        locationManager.delegate = self
        
        //set the desired accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //then request the authorization to retrieve the user's location
        locationManager.requestWhenInUseAuthorization()
        
        //then update the location data
        locationManager.startUpdatingLocation()
        
    }
    
    //now fetch the location data to work with it...
    //note that this function is executed each time the location is updated by the above methode '.startUpdatingLocation()' and so the map view will constantly be updated by this function
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //first we define the coordinates we are interested in (will vary based on user location)
        let userLatitude : CLLocationDegrees = locations[0].coordinate.latitude
        let userLongitude : CLLocationDegrees = locations[0].coordinate.longitude
        
        //create the coordinate point based on the obtain user location data
        let userLocation = CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude)
        
        //then create increments for the span of interest
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        //then create the actual span
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        //then define the region of interest based on this information
        let region = MKCoordinateRegion(center: userLocation, span: span)
        
        //and then set this region to the map view
        map.setRegion(region, animated: true)
        
        //BONUS: Annotate it!
        let annotation = MKPointAnnotation()
        annotation.coordinate = locations[0].coordinate
        annotation.title = "You are here."
        map.addAnnotation(annotation)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

