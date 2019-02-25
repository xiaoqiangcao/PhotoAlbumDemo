//
//  ViewController.swift
//  PhotoAlbumDemo
//
//  Created by 万想想 on 2019/2/25.
//  Copyright © 2019年 wanxiangxiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView: UITableView!
    var currnetIndexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
    }
    func setTableView() {
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    //MARK:tableView delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        //        print("numberOfSections")
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print("numberOfRowsInSection")
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //        print("heightForFooterInSection")
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //        print("viewForFooterInSection")
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //        print("heightForHeaderInSection")
        return 0.01
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        print("viewForHeaderInSection")
        return nil
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        print("heightForRowAt")
        return 100;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print("cellForRowAt")
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cellId")
        }
        cell?.imageView?.image = UIImage.init(named: "piao")
        cell?.textLabel?.text = "图集浏览转场效果"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = PhotoViewController()
        currnetIndexPath = indexPath
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.present(vc, animated: true, completion: nil)
    }
}
