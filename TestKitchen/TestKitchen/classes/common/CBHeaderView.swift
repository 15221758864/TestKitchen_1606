//
//  CBHeaderView.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/19.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CBHeaderView: UIView {

    private var titleLabel: UILabel?
    
    private var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //背景视图
        let bgView = UIView.createView()
        bgView.frame = CGRectMake(0, 10, bounds.width, bounds.height-10)
        bgView.backgroundColor = UIColor.whiteColor()
        addSubview(bgView)
        //标题文字
        let titleW: CGFloat = 100
        let imageW: CGFloat = 30
        
        let x = (bounds.width-titleW-imageW)/2
        titleLabel = UILabel.createLabel(nil, font: UIFont.boldSystemFontOfSize(18), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.frame = CGRectMake(x, 10, titleW, bounds.height-10)
        addSubview(titleLabel!)
        
        //右边图片
        imageView = UIImageView.createImageView("more_icon")
        imageView?.frame = CGRectMake(x+titleW, 14, imageW, imageW)
        addSubview(imageView!)
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
    }
    
    //显示标题
    func configTitle(title: String) {
        titleLabel?.text = title
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
