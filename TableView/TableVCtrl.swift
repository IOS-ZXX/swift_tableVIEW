//
//  TableVCtrl.swift
//  swift_tableVIEW
//
//  Created by MAC on 2017/5/23.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit

class TableVCtrl: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var openSection1 = true//第一组展开
    var openSection2 = true//第二组展开
    
    //申明属性
    var tableView = UITableView()
    let cellID = "CellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = true
        self.view.backgroundColor = UIColor.white;
        
        //tabelView初始化
        tableView.frame = CGRect(x:0,y:0,width:Screen_W,height:Screen_H)
        //        tableView.backgroundColor = UIColor.red;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellID)
        self.view.addSubview(tableView)
        
        UDefaults.set("hel", forKey: "hel")
        
        _ = UDefaults.object(forKey: "hel")
        
    }
    
    //MARK: -- tableView的代理
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //组头视图的高度
        if section == 0 {
            return 20
        } else if section == 1 {
            return 22
        }
        return 25;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //cell 的高度
        return 35;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //组尾视图的高度
        if section == 0 {
            return 0.1
        }else if section == 1{
            return 0.1
        }
        return 25
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //组的个数
        return 3;
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "这是\(section)组的组头"
    //    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "这是\(section)组的组尾视图"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //row的个数
        if (section == 0) {
            if openSection1 == false {
                return 0
            }
            return 10
        }else if(section == 1){
            if openSection2 == false {
                return 0
            }
            return 10
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //设置组头的视图
        let haederViwe = UIView()
        haederViwe.tag = 100+section;
        haederViwe.isUserInteractionEnabled = true
        
        let titleLb = UILabel(frame:CGRect(x: 5, y: 0, width: 200, height: 20))
        haederViwe.addSubview(titleLb)
        
        if section == 0 {
            haederViwe.backgroundColor = UIColor.red;
        } else if section == 1{
            haederViwe.backgroundColor = UIColor.orange
        }else{
            haederViwe.backgroundColor = UIColor.yellow
        }
        titleLb.text = "这是\(section)组的组头"
        
        //设置手势点击
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapClick))
        haederViwe.addGestureRecognizer(tap)
        
        return haederViwe
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        return footView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell的设置
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:cellID)!
        if(cell == nil){
            cell = UITableViewCell(style:.default,reuseIdentifier:cellID);
        }
        cell.textLabel?.text = "这是第\(indexPath.section)组.第\(indexPath.row)个Cell"
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//cell点击按钮
        
    }
    /*
     NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:i];// 0 是第一个组头; 1 是第二个组头 以此类推
     [_myTabele reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];//刷新该组的数据并加上动画效果
     */
    //MARK:  ----手势点击----
    func tapClick(sender:UITapGestureRecognizer) {
        let a = (sender.view?.tag)! - 100;
        if a == 0 {
            if openSection1 == true{
                openSection1 = false
            }else{
                openSection1 = true
            }
        }else if a == 1{
            if openSection2 == true {
                openSection2 = false
            } else {
                openSection2 = true
            }
        }else {
            return
        }
        
        let indexSet:IndexSet = NSIndexSet(index:a) as IndexSet
        tableView.reloadSections(indexSet, with: UITableViewRowAnimation.none)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

