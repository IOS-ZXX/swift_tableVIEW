//
//  MapKitViewCtrl.swift
//  swift_tableVIEW
//
//  Created by MAC on 2017/5/24.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapKitViewCtrl: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate{

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMapKitUI()
        
        getLocatInfo()
        // Do any additional setup after loading the view.
    }
    let mapView = MKMapView.init(frame: Screen)
    let locatManager = CLLocationManager.init()
    var point:MKPointAnnotation! = MKPointAnnotation.init()
    
    //获取自己位置信息
    func getLocatInfo() {
    
        locatManager.delegate = self;
        locatManager.desiredAccuracy = kCLLocationAccuracyBest;
        locatManager.distanceFilter = 10;
        let suthorStatus:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if suthorStatus == CLAuthorizationStatus.notDetermined {
            locatManager.requestWhenInUseAuthorization()
        }
        locatManager.startUpdatingLocation()
    }
    
    //MARK: ================CLLocationManagerDelegate 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //定位信息获取成功
        let  locat:CLLocation! = locations.last
        let coordin:MKCoordinateRegion! = MKCoordinateRegionMake(locat.coordinate, MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(coordin, animated:true)
        
        point.coordinate = locat.coordinate
        point.title = "我在这"
        point.subtitle = "我也不知道,这是哪!"
        mapView.addAnnotation(point)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        //定位信息获取失败
        
        
    }

    

    
    //获取地图信息
    func getMapKitUI() {
        
        self.view.addSubview(mapView)
        mapView.delegate = self;
        mapView.userTrackingMode = MKUserTrackingMode.follow
        mapView.mapType=MKMapType.standard
        
        let loogpress:UILongPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action:#selector(MapKitViewCtrl.loogPressClick))
        mapView.addGestureRecognizer(loogpress)
        
        let mapTypeArr = ["标准","卫星","混合"]
        let segment:UISegmentedControl! = UISegmentedControl.init(items: mapTypeArr)
        segment.frame = CGRect(x:50,y:50,width:300,height:50)
        mapView.addSubview(segment)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action:#selector(MapKitViewCtrl.mapTypeChanged), for: UIControlEvents.valueChanged)
        
        
        
    }

    //MARK: ================MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let circleRender = MKCircleRenderer.init(circle: overlay as! MKCircle)
        circleRender.fillColor = UIColor.purple
        circleRender.strokeColor = UIColor.orange
        
        return circleRender
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView:MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: "PIN")
        if annotationView == nil {
            annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "PIN")
        }
        
        let imagView = UIImageView.init(frame: CGRect(x:0,y:0,width:50,height:50))
        imagView.backgroundColor = UIColor.cyan
        annotationView?.leftCalloutAccessoryView = imagView;
        annotationView?.canShowCallout = true
        
        let label = UILabel.init(frame: CGRect(x:0,y:0,width:30,height:30))
        label.text = ">>>"
        annotationView?.rightCalloutAccessoryView = label;
        
        return annotationView;
    }
    
    var pointAnnotation = MKPointAnnotation.init()
    //MARK: =================长按按钮事件
    func loogPressClick(loogGest:UILongPressGestureRecognizer) {
        
        if loogGest.state != UIGestureRecognizerState.began {
            return;
        }
        
        let loogPressPoint = loogGest.location(in: mapView)
        let coordinate2D:CLLocationCoordinate2D = mapView.convert(loogPressPoint, toCoordinateFrom: mapView)
        
        
        pointAnnotation.coordinate = coordinate2D
        pointAnnotation.title = "我在这"
        pointAnnotation.subtitle = "你瞅啥呢"
        
        
        
        let circle = MKCircle.init(center: coordinate2D, radius: 50);
        mapView.add(circle)
        
    }

    
    //MARK: ==================mapTypeChanged
    func mapTypeChanged() {
        
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
