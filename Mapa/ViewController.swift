//
//  ViewController.swift
//  Mapa
//
//  Created by Użytkownik Gość on 27.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var MapView: MKMapView!
    @IBOutlet var ButtonStart: UIButton!
    @IBOutlet var ButtonStop: UIButton!
    @IBOutlet weak var ClearButton: UIButton!
    var myLocationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (CLLocationManager.locationServicesEnabled())
        {
            myLocationManager = CLLocationManager()
            myLocationManager.delegate = self
            myLocationManager.requestWhenInUseAuthorization()
        }
        ButtonStop.enabled = false;
        MapView.mapType = .HybridFlyover
        
    }

    @IBAction func StartButtonAction(sender: AnyObject) {
        ButtonStart.enabled = false
        ButtonStop.enabled = true
        myLocationManager.startUpdatingLocation()
        MapView.showsUserLocation = true
    }
    
    @IBAction func StopButtonAction(sender: AnyObject) {3
            ButtonStart.enabled = true
            ButtonStop.enabled = false
            
            MapView.showsUserLocation = false
            myLocationManager.stopUpdatingLocation()
    }
    
    @IBAction func ClearButtonAction(sender: AnyObject) {
        MapView.removeAnnotations(MapView.annotations)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let currentLocation = locations.last!.coordinate
        
        let currentLocationPin = MKPointAnnotation()
        currentLocationPin.coordinate = currentLocation
        MapView.addAnnotation(currentLocationPin)
        
        var spanDelta = 0.0
        if let speed = locations.last?.speed where speed > 0 {
            spanDelta = speed/5000
        }
        
        let locationArea = MKCoordinateRegion(center: currentLocation, span: MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta))
        MapView.setRegion(locationArea, animated: true)
    }
    
}

