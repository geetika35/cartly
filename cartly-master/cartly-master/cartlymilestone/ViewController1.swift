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

class ViewController1: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate, UIPopoverPresentationControllerDelegate{
    var locationManager: CLLocationManager = CLLocationManager()
    
    //fetch all location data from server and populate a set of batabases to pass on to corresponding views
    var data : NSMutableData!
    var currURL : NSURL!
    var foodCartsL0 = [foodCart]()
    var foodCartsL1 = [foodCart]()
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet weak var selectLocationLabel: UILabel!
    
    //Location description holders
    var an0Coords : CLLocationCoordinate2D!
    var an1Coords : CLLocationCoordinate2D!
    var an2Coords : CLLocationCoordinate2D!
    
    
    @IBAction func popover(sender: AnyObject) {
        self.performSegueWithIdentifier("popover", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //start connection to get JSON data
        self.data = NSMutableData()
        let url: NSURL = NSURL(string: "http://pages.cs.wisc.edu/~gandrews/testJSON.json")!
        let req: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: req, delegate: self)!
        //currURL = url
        connection.start()
        let url2 = NSURL(string: "http://pages.cs.wisc.edu/~gandrews/testJSON2.json")!
        //currURL = url2
        let req2: NSURLRequest = NSURLRequest(URL: url2)
        let connection2: NSURLConnection = NSURLConnection(request: req2, delegate: self)!
        connection2.start()
        //can parse a json file to determine scaling values for the radius size of the circles, just count the num
        //of unique food carts at the given location
        //get user permission for location
        locationManager.requestWhenInUseAuthorization()
        //Disable user interaction with map, they dont need to scroll in and out
        self.mapView.zoomEnabled = false;
        self.mapView.scrollEnabled = false;
        //Add location select label annimation
        selectLocationLabel.textColor = UIColor.redColor()
        view.addSubview(selectLocationLabel) // Important!
        //Animation options
        UIView.animateWithDuration(1.9, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
            
            self.selectLocationLabel.center = CGPoint(x: 200, y:50 )  // Ending position of the Label
            
            }, completion: nil)
        
        UIView.animateWithDuration(2.6, delay: 1.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
            
            self.selectLocationLabel.center = CGPoint(x: 200, y:150+90 )
            }, completion: nil)
        //self.mapView.userInteractionEnabled = false;
        //Start map over Madison:
        let span = MKCoordinateSpanMake(0.06, 0.06)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.074478, longitude: -89.387396), span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        //Start adding circles by defining their respective locations
        let location1 = CLLocation(latitude: 43.074927 as CLLocationDegrees, longitude: -89.398192 as CLLocationDegrees)
        addRadiusCircle(location1)
        
        //Annotations defined here
        //an0 = Library Mall/ State Street
        let an0 = MKPointAnnotation()
        an0.coordinate = CLLocationCoordinate2D(latitude: 43.074927, longitude: -89.398192)
        //print(an0.description)
        self.mapView.addAnnotation(an0)
        
        an0Coords = an0.coordinate
        
        //an1 = Dayton St/ GeoSci
        let an1 = MKPointAnnotation()
        an1.coordinate = CLLocationCoordinate2D(latitude: 43.070997, longitude: -89.406588)
        self.mapView.addAnnotation(an1)
        
        an1Coords = an1.coordinate
        
        
        let an2 = MKPointAnnotation()
        an2.coordinate = CLLocationCoordinate2D(latitude: 43.073146, longitude: -89.382064)
        self.mapView.addAnnotation(an2)
        
        an2Coords = an2.coordinate
        
    }
    
    let location2 = CLLocation(latitude: 43.070997 as CLLocationDegrees, longitude: -89.406588 as CLLocationDegrees)
    
    let location3 = CLLocation(latitude: 43.073146 as CLLocationDegrees, longitude: -89.382064 as CLLocationDegrees)
    
    //Unused location point
    let location4 = CLLocation(latitude: 43.070997 as CLLocationDegrees, longitude: -89.406588 as CLLocationDegrees)
    
    
    //Adding the custom overlay circle to the map
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //var DestViewConroller : UIViewController //= segue.destinationViewController as UIViewController
        if segue.identifier == "popover" {
            let vc = segue.destinationViewController
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
        }
        if segue.identifier == "an0"
        {
            //set key to fetch corresponging json file from server
            print("an0 segue")
            print(self.foodCartsL0.first?.name)
            if let DestVC = segue.destinationViewController as? Location0TableViewController{
                DestVC.foodCartsL0 = self.foodCartsL0
            }
            else {
                print("ERROR")
            }
        }
        else if segue.identifier == "an1"
        {
            //set key to fetch corresponging json file from server
            print("an1 segue")
        }
        else if segue.identifier == "an2"
        {
            //set key to fetch corresponging json file from server
            print("an2 segue")
        }
        else {
            return
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView){
        print("click")
        
        //check for geocoords to determine which one was selected
        let objCoords = view.annotation!.coordinate
        if objCoords.latitude == an0Coords.latitude && objCoords.longitude == an0Coords.longitude
        {
            print("an0")
            self.performSegueWithIdentifier("an0", sender: self)
        }
        else if objCoords.latitude == an1Coords.latitude && objCoords.longitude == an1Coords.longitude {
            print("an1")
            self.performSegueWithIdentifier("an1", sender: self)
        }
        else if objCoords.latitude == an2Coords.latitude && objCoords.longitude == an2Coords.longitude{
            print("an2")
            self.performSegueWithIdentifier("an2", sender: self)
        }
    }
    // MARK: NSURLConnection functions
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.data.length = 0
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.data.appendData(data)
        
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        print(connection.originalRequest.URL)
        do {
            if connection.originalRequest.URL?.absoluteString == "http://pages.cs.wisc.edu/~gandrews/testJSON.json" {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options: []) as? NSDictionary {
                    print(jsonResult)
                    if let cartLocale : NSInteger = jsonResult.objectForKey("Saigon Sandwich") as? NSInteger {
                        let newCart: foodCart = foodCart(name: "Saigon Sandwich", isAtLocation: cartLocale)
                        print("LOOK HERE")
                        print(newCart.name)
                        foodCartsL0.append(newCart)
                    }
                    if let cartLocale : NSInteger = jsonResult.objectForKey("Banzo") as? NSInteger {
                        let newCart: foodCart = foodCart(name: "Banzo", isAtLocation: cartLocale)
                        foodCartsL0.append(newCart)
                    }
                    if let cartLocale : NSInteger = jsonResult.objectForKey("Batter Brothers") as? NSInteger {
                        let newCart: foodCart = foodCart(name: "Batter Brothers", isAtLocation: cartLocale)
                        foodCartsL0.append(newCart)
                    }
                }
            }
            if connection.originalRequest.URL?.absoluteString == "http://pages.cs.wisc.edu/~gandrews/testJSON2.json" {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options: []) as? NSDictionary {
                    print(jsonResult)
                    if let cartLocale : NSInteger = jsonResult.objectForKey("Saigon Sandwich") as? NSInteger {
                        let newCart: foodCart = foodCart(name: "Saigon Sandwich", isAtLocation: cartLocale)
                        foodCartsL1.append(newCart)
                    }
                    if let cartLocale : NSInteger = jsonResult.objectForKey("Banzo") as? NSInteger {
                        let newCart: foodCart = foodCart(name: "Banzo", isAtLocation: cartLocale)
                        foodCartsL1.append(newCart)
                    }
                    if let cartLocale : NSInteger = jsonResult.objectForKey("Batter Brothers") as? NSInteger {
                        let newCart: foodCart = foodCart(name: "Batter Brothers", isAtLocation: cartLocale)
                        foodCartsL1.append(newCart)
                    }
                }
            }
        } catch {
            print(error)
        }
        
        connection.cancel()
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        print("Error During Connection: \(error.description)")
    }
}


