//
//  CollectionVCtrl.swift
//  swift_tableVIEW
//
//  Created by MAC on 2017/3/15.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit

class CollectionVCtrl: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //初始化 collect
    var collection : UICollectionView!
    let cellID = "CellID"
    
    var type = 1;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.automaticallyAdjustsScrollViewInsets = true;
        
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5;
        
        collection = UICollectionView(frame:CGRect(x: 0, y: 0, width: Screen_W, height: Screen_H),collectionViewLayout:layout)
        collection.backgroundColor = UIColor.lightGray;
        collection.dataSource = self;
        collection.delegate = self;
        collection .register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellID)
        self.view.addSubview(collection)
        
        collection.register(CollectHaeder.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        
    }
 
//MARK: ---======CollectView的代理协议======---
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //组的个数
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        //设置组头 或 组尾视图
        
        var reusable = CollectHaeder();
        
        for subview in reusable.subviews {
            subview.removeFromSuperview()
        }
        
        if kind == UICollectionElementKindSectionHeader {
            reusable = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! CollectHaeder
            reusable.tag = indexPath.row + 200
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(TapClick))
            
            reusable.addGestureRecognizer(tap)
            
            switch indexPath.section {
            case 0:
                reusable.backgroundColor = UIColor.red
            break
            case 1:
                reusable.backgroundColor = UIColor.orange
                break
            case 2:
                reusable.backgroundColor = UIColor.yellow
                break
            case 3:
                reusable.backgroundColor = UIColor.green
                break
            case 4:
                reusable.backgroundColor = UIColor.blue
                break
            default:
                reusable.backgroundColor = UIColor.purple
                break
                
            }
            reusable.label.text = "\(indexPath.section)组头"
        }

        
        return reusable;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //设置item的个数
        if type == 0 {
            return 0
        }
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //设置cell
        let cell:UICollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        cell.backgroundColor = UIColor.white;
        return cell
    }
    
   
    
    func TapClick() {
        type ^= 1;
        
        collection.reloadData()
    }
    
//MARK: ---=======UICollectionViewFlowLayout协议代理=======----
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(20, 10, 40, 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)//layout  大小
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
           //设置组头的尺寸
        return CGSize.init(width: Screen_W, height: 40)
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
