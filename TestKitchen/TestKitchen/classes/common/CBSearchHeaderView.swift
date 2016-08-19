//
//  CBSearchHeaderView.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/18.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CBSearchHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //搜索框
        /*
        let searchBar = UISearchBar(frame: CGRectMake(40, 0, bounds.size.width-40*2, bounds.size.height))
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.alpha = 0.5
        searchBar.placeholder = "输入菜名或食材搜索"
                addSubview(searchBar)
         */
        
        let textField = UITextField(frame: CGRectMake(40, 4, bounds.size.width-40*2, bounds.size.height-4*2))
        textField.borderStyle = .RoundedRect
        textField.placeholder = "输入菜名或食材搜索"
        addSubview(textField)
        //左边搜索图片
        let imgView = UIImageView.createImageView("search")
        textField.leftView = imgView
        textField.leftViewMode = .Always
        imgView.frame = CGRectMake(0, 0, 25, 25)
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   
}
