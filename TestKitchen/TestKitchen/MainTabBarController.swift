//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/15.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    //tabbar背景视图
    private var bgView: UIView?
    
    
    //json文件对应的数组
    //计算属性
    private var array: Array<Dictionary<String,String>>?{
        get {
            let path = NSBundle.mainBundle().pathForResource("Ctrl.json", ofType: nil)
            var myArray: Array<Dictionary<String,String>>? = nil
            
            if let filePath = path {
                let data = NSData(contentsOfFile: filePath)
                if let jsonData = data{
                    
                    do {
                        let jsonValue = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                        if jsonValue.isKindOfClass(NSArray.self) {
                            myArray = jsonValue as? Array<Dictionary<String,String>>
                        }
                    }catch{
                        print(error)
                        return nil
                    }
                }
            }
            return myArray!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //swift里面,一般在类的内部调用属性和方法的时候,可以不写self,一般在闭包里面写self
        createViewControllers()
    }
    
    func createViewControllers(){
        
        var imageNames = [String]()//tabbar上面的图片
        var ctrlNames = [String]()
        var titleNames = [String]()
        
        if let tmpArray = self.array{
            for dict in tmpArray {
                let titleName = dict["titleName"]
                let imageName = dict["imageName"]
                let name = dict["ctrlName"]
                
                titleNames.append(titleName!)
                imageNames.append(imageName!)
                ctrlNames.append(name!)
            }
        }else{
            ctrlNames = ["TestKitchen.CookBookViewController",  "TestKitchen.CommunityViewController",  "TestKitchen.MallViewController", "TestKitchen.FoodClassViewController", "TestKitchen.ProfileViewController"]
            /*
             community_normal@2x home_normal@2x mine_normal@2x report_normal@2x shike_normal@2x shop_normal@2x
             community_select@2x home_select@2x mine_select@2x report_select@2x shike_select@2x shop_select@2x
             */
            titleNames = ["食材", "社区", "商城", "食客", "我的"]
            imageNames = ["home", "community", "shop", "shike", "mine"]
            
        }
        var vCtrlArray = Array<UINavigationController>()
        for i in 0..<ctrlNames.count {
            let ctrlName = ctrlNames[i]
            let cls = NSClassFromString(ctrlName)as! UIViewController.Type
            let ctrl = cls.init()
            let navCtrl = UINavigationController(rootViewController: ctrl)
            vCtrlArray.append(navCtrl)
        }
        self.viewControllers = vCtrlArray
        
        //自定制tabbar
        self.createCustomTabbar(titleNames, imageNames: imageNames)
    }
    
    func createCustomTabbar(titleNames: [String], imageNames: [String])  {
        //创建背景视图
        bgView = UIView.createView()
        bgView?.backgroundColor = UIColor.whiteColor()
        //设置边框
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(bgView!)
        
        //添加约束
        self.bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view.snp_bottom).offset(-49)
        })
        
        //循环添加按钮
        //按钮的宽度
        let width = kScreenWidth/5.0
        
        for i in 0..<imageNames.count {
            
            let imageName = imageNames[i]
            let titleName = titleNames[i]
            let bgImageName = imageName + "_normal@2x"
            
            let selectImageName = imageName + "_select@2x"
            
            //循环创建按钮
            let btn = UIButton.createBtn(nil, target: self, action: #selector(clickBtn(_:)), bgImageName: bgImageName, selectBgImageName: selectImageName)
            bgView?.addSubview(btn)
            
            //添加约束
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
            })
            
            //2.2文字
            let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(8), textAlignment: .Center, textColor: .grayColor())
            btn.addSubview(label)
            
            //约束
            label.snp_makeConstraints(closure: {
                (make) in
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(12)
            })
            //设置tag值
            btn.tag = 300+i
            label.tag = 400
            
            //默认选中第一个按钮
            if i == 0 {
                btn.selected = true
                label.textColor = UIColor(red: 246.0/255.0, green: 123.0/255.0, blue: 68.0/255.0, alpha: 1.0)
            }
        }
    }
    func clickBtn(curBtn: UIButton) {
        //1取消之前选中按钮状态
        let lastBtnView = self.view.viewWithTag(300+selectedIndex)
        if let tmpBtn = lastBtnView {
            //上次选中的按钮
            let lastBtn = tmpBtn as! UIButton
            let lastView = tmpBtn.viewWithTag(400)
            if let tmpLabel = lastView {
                //上次选中的标签
                let lastLabel = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
        }
        
        //2设置当前选中按钮的状态
        let curLabelView = curBtn.viewWithTag(400)
        if let tmpLabel = curLabelView {
            let curLabel = tmpLabel as! UILabel
            curBtn.selected = true
            curLabel.textColor = UIColor(red: 246.0/255.0, green: 123.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        }
        //3选中视图控制器
        selectedIndex = curBtn.tag - 300
    }
}
