//
//  CBRecommendView.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/17.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CBRecommendView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var tbView: UITableView?
    var model: CBRecommendModel?{
        didSet{
            tbView?.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        self.addSubview(tbView!)
        
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CBRecommendView{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sectionNum = 1
        if model?.data?.widgetList?.count > 0 {
            //广告的数据
            sectionNum += (model?.data?.widgetList?.count)!
        }
        
        return sectionNum
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0 {
            //广告的数据
            if model?.data?.banner?.count > 0 {
                rowNum = 1
            }
        }else{
            //其他的情况
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgeType.GuessYourLike.rawValue {
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == WidgeType.RedPackage.rawValue{
                rowNum = 1
            }
        }
        
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 0
        if indexPath.section == 0 {
            //广告的高度
            if model?.data?.banner?.count > 0 {
                height = 160
            }
            
        }else{
            //其他的情况
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == WidgeType.GuessYourLike.rawValue {
                height = 80
            }else if listModel?.widget_type?.integerValue == WidgeType.RedPackage.rawValue{
                height = 80
            }

            
        }
        return height
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            //广告
            if model?.data?.banner?.count > 0 {
                cell = CBRecommendADCell.createAdCellFor(tableView, atIndexPath: indexPath, withModel: model!)
            }
        }else{
            //其他的情况
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == WidgeType.GuessYourLike.rawValue {
                //猜你喜欢
                cell = CBRecommendLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgeType.RedPackage.rawValue{
                cell = CBRedPacketCell.createRedPacketCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }
            
        }
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView: UIView? = nil
        if section > 0 {
            //其他的情况
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgeType.GuessYourLike.rawValue {
                //猜你喜欢
                headerView = CBSearchHeaderView(frame: CGRectMake(0, 0, kScreenWidth, 44))
                
            }
            
        }
        return headerView
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0
        
        if section > 0 {
            //其他的情况
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgeType.GuessYourLike.rawValue {
                //猜你喜欢
                height = 44
            }
        }
        return height
    }
    
    

}

