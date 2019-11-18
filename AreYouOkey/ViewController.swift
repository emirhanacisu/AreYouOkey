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
import UserNotifications

class ViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{

    //var ref: DatabaseReference? = nil
    //let data = Database.database().reference()
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var enlem: UITextField!
    @IBOutlet weak var boylam: UITextField!
    @IBOutlet weak var paylasiliyor: UILabel!
    
    var problem = ""
    var postData = [String]()
    var databaseHandle:DatabaseHandle?
    
   var locationManager = CLLocationManager()
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        let refProblem = Database.database().reference().child("Posts")
//                     let postProblem = ["Problem" : "0"] as [String:Any]
//
//
//
//                     refProblem.setValue(postProblem, withCompletionBlock: { error , ref in
//                                if error == nil{
//                                    self.dismiss(animated: true, completion: nil)
//
//
//                                }
//                                else{
//                                    //handle error
//                                }
//                            })
//    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let refProblem = Database.database().reference().child("Posts")
                     let postProblem = ["Problem" : "0"] as [String:Any]



                     refProblem.setValue(postProblem, withCompletionBlock: { error , ref in
                                if error == nil{
                                    self.dismiss(animated: true, completion: nil)
                                }
                                else{
                                    //handle error
                                }
                            })

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let refProblem = Database.database().reference().child("Posts")
               let postProblem = ["Problem" : "0"] as [String:Any]



               refProblem.setValue(postProblem, withCompletionBlock: { error , ref in
                          if error == nil{
                              self.dismiss(animated: true, completion: nil)
                          }
                          else{
                              //handle error
                          }
                      })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let refProblem = Database.database().reference().child("Posts")
        let postProblem = ["Problem" : "0"] as [String:Any]



        refProblem.setValue(postProblem, withCompletionBlock: { error , ref in
                   if error == nil{
                       self.dismiss(animated: true, completion: nil)
                   }
                   else{
                       //handle error
                   }
               })
        
        
        
        
        let ref = Database.database().reference()
                     databaseHandle = ref.child("Posts").observe(.childChanged, with: { (snapshot) in
                         let post = snapshot.value as? String
                       
                         self.problem = String(post!)
                         print(self.problem)
                        
                        
                        if (self.problem != "0"){

                                    
                                    
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "baslik"
        notificationContent.subtitle = "altbaslik"
        notificationContent.body = "bildirim acıklaması"
        notificationContent.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let identifier = "Benim Bildirimim"
        let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)

            if (self.problem != "0") {
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
                        }
                       
                     })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let refProblem = Database.database().reference().child("Posts")
               let postProblem = ["Problem" : "0"] as [String:Any]



               refProblem.setValue(postProblem, withCompletionBlock: { error , ref in
                          if error == nil{
                              self.dismiss(animated: true, completion: nil)


                            let notificationContent = UNMutableNotificationContent()
                                   notificationContent.title = "baslik"
                                   notificationContent.subtitle = "altbaslik"
                                   notificationContent.body = "bildirim acıklaması"
                                   notificationContent.sound = UNNotificationSound.default
                                   let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                                   let identifier = "Benim Bildirimim"
                                   let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)

                                       if (self.problem != "0") {
                                               UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                       }


                          }
                          else{
                              //handle error
                          }
                      })

    }
    
    
   
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)

        let span = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
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
                            "Longitude": locations[0].coordinate.longitude /*,
                            "Problem" : "0"*/] as [String:Any]
        let postObject2 = ["Problem" : "0"] as [String:Any]

        

        postRef.setValue(postObject, withCompletionBlock: { error , ref in
                   if error == nil{
                       self.dismiss(animated: true, completion: nil)
                   }
                   else{
                       //handle error
                   }
               })
        
        let postRef2 = Database.database().reference().child("Posts")
        postRef2.setValue(postObject2, withCompletionBlock: { error , ref in
                          if error == nil{
                              self.dismiss(animated: true, completion: nil)
                            self.problem = "0"
                          }
                          else{
                              //handle error
                          }
                      })
        

    }
    
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if (sender.isOn == true){
            
            
            paylasiliyor.text = "Konum Paylasiliyor"
            let maps = MKMapView()
            maps.delegate = self
          //  self.problem = "0"
            print("anahtar problem" + problem )
                         locationManager.delegate = self
                         locationManager.desiredAccuracy = kCLLocationAccuracyBest
                         locationManager.requestWhenInUseAuthorization()
                         locationManager.startUpdatingLocation()
            
            

            
        }
        else{
            paylasiliyor.text = "Konum Paylasılmıyor"
            self.problem = "0"
            let location = CLLocationCoordinate2D(latitude: 29.400303, longitude: 39.00023)

            let span = MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region,animated : true)
            enlem.text = ""
            boylam.text = ""
            
            locationManager.stopUpdatingLocation()
        }
     }
  
 

}

