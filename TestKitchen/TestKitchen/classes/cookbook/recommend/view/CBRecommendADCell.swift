//
//  CBRecommendADCell.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/17.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CBRecommendADCell: UITableViewCell {

    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var bannerArray: Array<CBRecommendBannerModel>? {
        
        didSet {
            
            //显示UI
            showData()
            
        }
        
    }
    
    func showData() {
        //删除之前的子视图
        for sub in scrollView.subviews {
            sub.removeFromSuperview()
        }
        
        let cnt = bannerArray?.count
            if cnt > 0 {
                //添加一个容器视图
                let contentView = UIView.createView()
                scrollView.addSubview(contentView)
                contentView.snp_makeConstraints(closure: {
                    [weak self]
                    (make) in
                    make.edges.equalTo(self!.scrollView)
                    make.height.equalTo(self!.scrollView)
                })
                
                
                var lastView: UIView? = nil
                for i in 0..<cnt! {
                    //1. 获取模型对象
                    let model = bannerArray![i]
                    
                    //循环创建图片
                    let tmpImageView = UIImageView.createImageView(nil)
                    
                    //在线加载图片
                    /**
                     //在线加载图片
                     
                     - parameter <TURL:             图片网址的URL
                     - parameter placeholderImage:  默认图片
                     - parameter optionsInfo:       选项
                     - parameter progressBlock:     可以获取下载的进度
                     - parameter completionHandler: 下载结束的时候的操作
                     */
                    let url = NSURL(string: model.banner_picture!)
                    let image = UIImage(named: "sdefaultImage")
                    
                    tmpImageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    contentView.addSubview(tmpImageView)
                    
                    //约束
                    tmpImageView.snp_makeConstraints(closure: { (make) in
                        make.top.bottom.equalTo(contentView)
                        make.width.equalTo(kScreenWidth)
                        if i == 0 {
                            make.left.equalTo(contentView)
                        }else{
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                    })
                    lastView = tmpImageView
                }
                //修改容器视图的约束
                contentView.snp_makeConstraints(closure: {
                    (make) in
                    make.right.equalTo((lastView?.snp_right)!)
                })
                
                //修改分页控件
                pageCtrl.numberOfPages = cnt!
                scrollView.delegate = self
                scrollView.pagingEnabled = true
                scrollView.showsHorizontalScrollIndicator = false
//                scrollView.bounces = false
        }
    }
    
    
    //创建cell的方法
    class func createAdCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model: CBRecommendModel) -> CBRecommendADCell{
    
        let cellID = "CBRecommendADCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)as? CBRecommendADCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendADCell", owner: nil, options: nil).last as? CBRecommendADCell
        }
        
        //显示数据
        cell?.bannerArray = model.data?.banner
        
        return cell!
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}


extension CBRecommendADCell: UIScrollViewDelegate{

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        pageCtrl.currentPage = index
    }
    
    
}

