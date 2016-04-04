//
//  ViewController.swift
//  Cartly
//
//  Created by Garrett Andrews on 3/30/16.
//  Copyright © 2016 Garrett Andrews. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import MapKit

import Foundation
import MapKit

class ViewController1: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    var locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //can parse a json file to determine scaling values for the radius size of the circles, just count the num
        //of unique food carts at the given location
        //get user permission for location
        locationManager.requestWhenInUseAuthorization()
        //Disable user interaction with map, they dont need to scroll in and out
        self.mapView.zoomEnabled = false;
        self.mapView.scrollEnabled = false;
        //self.mapView.userInteractionEnabled = false;
        //Start map over Madison:
        let span = MKCoordinateSpanMake(0.06, 0.06)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.074478, longitude: -89.387396), span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        //Start adding circles by defining their respective locations
    let location1 = CLLocation(latitude: 43.074927 as CLLocationDegrees, longitude: -89.398192 as CLLocationDegrees)
        addRadiusCircle(location1)
    }
    
    let location2 = CLLocation(latitude: 43.070997 as CLLocationDegrees, longitude: -89.406588 as CLLocationDegrees)
    
    let location3 = CLLocation(latitude: 43.073146 as CLLocationDegrees, longitude: -89.382064 as CLLocationDegrees)
    
    //Unused location point
    let location4 = CLLocation(latitude: 43.070997 as CLLocationDegrees, longitude: -89.406588 as CLLocationDegrees)

    func addRadiusCircle(location1: CLLocation){
        self.mapView.delegate = self
        let circle = MKCircle(centerCoordinate: location1.coordinate, radius: 100 as CLLocationDistance)
        self.mapView.addOverlay(circle)
        let circle2 = MKCircle(centerCoordinate: location2.coordinate, radius: 100 as CLLocationDistance)
        self.mapView.addOverlay(circle2)
        let circle3 = MKCircle(centerCoordinate: location3.coordinate, radius: 100 as CLLocationDistance)
        self.mapView.addOverlay(circle3)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
            circle.lineWidth = 1
            return circle
        } else {
            return MKPolylineRenderer()
        }
    }
    //End adding circles to map
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        //prepareForSegue(UIStoryboardSegue, sender: AnyObject?)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
      //var DestViewConroller : UIViewController //= segue.destinationViewController as UIViewController
        
        if segue.identifier == "circle0"
        {
           //Circle0ViewController = segue.destinationViewController
        }
        else if segue.identifier == "circle1"
        {
            //set next view to corresponding list
        }
        else if segue.identifier == "circle2"
        {
            //set next view to corresponding list
        }
        else {
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView){
        print("click")
    }


}

