//
//  ViewController.swift
//  AreYouOkey
//
//  Created by Erhan Acisu on 12.11.2019.
//  Copyright © 2019 Emirhan Acisu. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

class ViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{

    //var ref: DatabaseReference? = nil
    //let data = Database.database().reference()
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var enlem: UITextField!
    @IBOutlet weak var boylam: UITextField!
    @IBOutlet weak var paylasiliyor: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

              mapView.delegate = self
             
        
        
        
    }
    @IBAction func `switch`(_ sender: UISwitch) {
        if (sender.isOn == true){
            paylasiliyor.text = "Konum Paylasiliyor"
            
            
            locationManager.delegate = self
                         locationManager.desiredAccuracy = kCLLocationAccuracyBest
                         locationManager.requestWhenInUseAuthorization()
                         locationManager.startUpdatingLocation()
            
            
            
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                   let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                   
                   let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                   let region = MKCoordinateRegion(center: location, span: span)
                   mapView.setRegion(region,animated : true)
                   
                   
                   if let enlem = locations[0].coordinate.latitude as? Double {
                       self.enlem.text = String(enlem)
                       
                   }
                   if let boylam = locations[0].coordinate.longitude as? Double {
                       self.boylam.text = String(boylam)

                   }
                 
                   
                   let postRef = Database.database().reference()//.child("posts").childByAutoId()
                  // let postObject = ["Latitude" : locations[0].coordinate.latitude ,
                                   //  "longitude": locations[0].coordinate.longitude] as [String:Any]
                   
                  let postObject = ["Latitude" : locations[0].coordinate.latitude ,
                                       "Longitude": locations[0].coordinate.longitude] as [String:Any]
                   
                   
                   
                   postRef.setValue(postObject, withCompletionBlock: { error , ref in
                              if error == nil{
                                  self.dismiss(animated: true, completion: nil)
                              }
                              else{
                                  //handle error
                              }
                          })
                   
               }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        else{
            paylasiliyor.text = "Konum Paylasılmıyor"
        }
    }
    
    
   
    
 

}

