//
//  ViewController.swift
//  swift_tableVIEW
//
//  Created by MAC on 2017/5/23.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit


class ViewController: UIViewController{


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBottomBarWhenPushed = true;

        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ToMapKitButton(_ sender: Any) {
        let mapView = MapKitViewCtrl();
        self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    @IBAction func getLocat(_ sender: Any) {
        let location = LocationViewCtrl()
        self.navigationController?.pushViewController(location, animated: true)
    }

    @IBAction func tableViewBtn(_ sender: UIButton) {
        let tableView = TableVCtrl()
        self.navigationController?.pushViewController(tableView, animated: true)
    }

    @IBAction func collectionviewBtn(_ sender: UIButton) {
        let collection = CollectionVCtrl()
        self.navigationController?.pushViewController(collection, animated: true)
    }
    
    
   /*
    func HGLog<T>(_ message:T, file:String = #file, function:String = #function,
               line:Int = #line) {
        #if DEBUG
            //获取文件名
            let fileName = (file as NSString).lastPathComponent
            //打印日志内容
            print("\n [这是 \(fileName) 类] \n [\(function) 方法] \n [第 \(line) 行] \n \(message)")
        #endif
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
