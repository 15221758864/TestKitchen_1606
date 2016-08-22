//
//  BaseViewController.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/15.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addNavTitle(title: String) {
        let titleLabel = UILabel.createLabel(title, font: UIFont.boldSystemFontOfSize(24), textAlignment: .Center, textColor: UIColor.blackColor())
        navigationItem.titleView = titleLabel
    }

    func addNavBtn(imageName: String, target: AnyObject?, action: Selector, isLeft: Bool) {
        let btn = UIButton.createBtn(nil, target: target, action: action, bgImageName: imageName, selectBgImageName: nil)
        let barBtnItem = UIBarButtonItem(customView: btn)
        btn.frame = CGRectMake(0, 20, 25, 35)
        if isLeft {
            navigationItem.leftBarButtonItem = barBtnItem
        }else{
            navigationItem.rightBarButtonItem = barBtnItem
        }
    }
    
    func addNavBackBtn() {
        
        self.addNavBtn("", target: self, action: #selector(backAction), isLeft: true)
        
    }
    func backAction() {
        navigationController?.popViewControllerAnimated(true)
    }
}
