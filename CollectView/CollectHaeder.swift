//
//  CollectHaeder.swift
//  swift_tableVIEW
//
//  Created by MAC on 2017/4/21.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit

class CollectHaeder: UICollectionReusableView {
    var label = UILabel();//文字
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cerateUIView();
    }
    
    func cerateUIView() -> Void {
        label = UILabel(frame:CGRect(x: 10, y: 5, width: 70 ,height:30))
        self.addSubview(label)
    }
    
    func setViewData(array:NSArray) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
