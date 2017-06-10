//
//  LocationViewCtrl.swift
//  swift_tableVIEW
//
//  Created by MAC on 2017/5/24.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewCtrl: UIViewController ,CLLocationManagerDelegate{
    
   @IBOutlet var weiduLab: UILabel!
    @IBOutlet var jingduLab: UILabel!
    @IBOutlet var weizhiLab: UILabel!
    
    var locat : CLLocationManager! = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getCLLocationInfo();
    }

    
    func getCLLocationInfo(){
        
        if CLLocationManager.locationServicesEnabled() {
            locat = CLLocationManager()
            locat.requestWhenInUseAuthorization()
            locat.desiredAccuracy = kCLLocationAccuracyBest
            locat.delegate = self;
            locat.startUpdatingLocation()
        }else{
            print("定位失败!!!!");
        }
        
    }
    
    //MARK: 定位delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //定位成功
        let loctaion:CLLocation = locations.last!;
        let coordinate:CLLocationCoordinate2D = loctaion.coordinate;
        //        let direction = loctaion.course
        //        let speed = loctaion.speed
        
        jingduLab.text = "经度: \(coordinate.longitude)"
        weiduLab.text = "纬度: \(coordinate.latitude)"
        //        let date = NSDate();
        
        let clgeo:CLGeocoder = CLGeocoder();
        clgeo.reverseGeocodeLocation(loctaion) { (placemarks : [CLPlacemark]?,error: Error?) in
            if (placemarks?.count)! > 0 {
                var dict : NSDictionary = NSDictionary()
                for place in (placemarks)! {
                    
                    dict = place.addressDictionary! as NSDictionary
                }
                
                let adderArr:NSArray = dict.object(forKey:"FormattedAddressLines") as! NSArray;
                let adder = String().appendingFormat("位置: %@", adderArr.firstObject as! CVarArg)
                self.weizhiLab.text = adder;
            }else{
                print("定位失败,没有获取位置信息")
            }
        }
        
        manager.stopUpdatingLocation();
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //定位失败
        manager.stopUpdatingLocation()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
