//
//  CBWorksCell.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/22.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CBWorksCell: UITableViewCell {
    //显示数据
    var model: CBRecommendWidgetListModel?{
        didSet{
            showData()
        }
    }
    
    func showData() {
        //i表示列的序号
        for i in 0..<3 {
            //i    0    1    2
            //
            
            //大图片
            //index  0    3    6
            if model?.widget_data?.count > i*3 {
                let imageModel = model?.widget_data![i*3]
                if imageModel?.type == "image" {
                    //获取按钮
                    let subView = contentView.viewWithTag(100+i)
                    if subView?.isKindOfClass(UIButton.self) == true {
                        let btn = subView as! UIButton
                        let url = NSURL(string: (imageModel?.content)!)
                        btn.kf_setImageWithURL(url, forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }
            
            
            //用户图片
            //index  1    4    7
            if model?.widget_data?.count > i*3+1 {
                let imageModel = model?.widget_data![i*3+1]
                if imageModel?.type == "image" {
                    //获取按钮
                    let subView = contentView.viewWithTag(200+i)
                    if subView?.isKindOfClass(UIButton.self) == true {
                        let btn = subView as! UIButton
                        btn.layer.cornerRadius = 20 //设置圆角
                        let url = NSURL(string: (imageModel?.content)!)
                        btn.kf_setImageWithURL(url, forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }

            //用户名
            //index  2    5    8
            if model?.widget_data?.count > i*3+2 {
                let imageModel = model?.widget_data![i*3+2]
                if imageModel?.type == "text" {
                    //获取按钮
                    let subView = contentView.viewWithTag(300+i)
                    if subView?.isKindOfClass(UILabel.self) == true {
                        let label = subView as! UILabel
                        label.text = imageModel?.content!
                    }
                }
            }
        }
        let subView = contentView.viewWithTag(400)
        if subView?.isKindOfClass(UILabel.self) == true {
            let descLabel = subView as! UILabel
            descLabel.text = model?.desc
        }
    }
    
    @IBAction func clickUserBtn(sender: UIButton) {
    }
    @IBAction func clickBtn(sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func createWorksCell(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withListModel listModel: CBRecommendWidgetListModel) -> CBWorksCell {
        let cellID = "worksCellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)as? CBWorksCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBWorksCell", owner: nil, options: nil).last as? CBWorksCell
        }
        cell?.model = listModel
        return cell!
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
