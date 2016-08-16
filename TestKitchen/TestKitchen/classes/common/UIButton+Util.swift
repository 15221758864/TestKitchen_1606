//
//  UIButton+Util.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/15.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

extension UIButton{
    
    class func createBtn(title: String?, target: AnyObject?, action: Selector, bgImageName: String?, selectBgImageName: String?)-> UIButton {
        let btn = UIButton(type: .Custom)
        if let btnTitle = title {
            btn.setTitle(btnTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if let btnBgImageName = bgImageName {
            btn.setBackgroundImage(UIImage(named: btnBgImageName), forState: .Normal)
        }
        if let btnselectBgImageName = selectBgImageName {
            btn.setBackgroundImage(UIImage(named: btnselectBgImageName), forState: .Selected)
        }
        if let btnTarget = target {
            btn.addTarget(btnTarget, action: action, forControlEvents: .TouchUpInside)
        }
        return btn
    }
}


