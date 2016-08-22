//
//  CBSpecialCell.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/19.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CBSpecialCell: UITableViewCell {

    var model: CBRecommendWidgetListModel? {
    
        didSet {
        
            showData()
            
        }
        
    }
    
    func showData() {
        
        //类型图片
        if model?.widget_data?.count > 0 {
            let imageModel = model?.widget_data![0]
            if imageModel?.type == "image" {
                
                //获取类型按钮
                let subView = contentView.viewWithTag(100)
                if subView?.isKindOfClass(UIButton.self) == true {
                    let sceneBtn = subView as? UIButton
                    let url = NSURL(string: (imageModel?.content)!)
                    let dImage = UIImage(named: "sdefaultImage")
                    sceneBtn?.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
        //类型的名字
        if model?.widget_data?.count > 1 {
            let nameModel = model?.widget_data![1]
            if nameModel?.type == "text" {
                //获取名字的label
                let subVIew = contentView.viewWithTag(101)
                if subVIew?.isKindOfClass(UILabel.self)==true {
                    let nameLabel = subVIew as! UILabel
                    nameLabel.text = nameModel?.content
                }
            }
        }
        //多少道菜
        if model?.widget_data?.count > 2 {
            let numModel = model?.widget_data![2]
            if numModel?.type == "text" {
                //获取label
                let subVIew = contentView.viewWithTag(102)
                if subVIew?.isKindOfClass(UILabel.self)==true {
                    let numLabel = subVIew as! UILabel
                    numLabel.text = numModel?.content
                }
            }

        }
        
        //列举菜例的图片显示
        for i in 0..<4 {
            //图片数据在数组中的序号
            //i        0  1  2  3
            //index    3  5  7  9
            //index-3  0  2  4  6
            
            let index = i*2+3
            if model?.widget_data?.count>index {
                let imageModel = model?.widget_data![index]
                if imageModel?.type == "image" {
                    //获取按钮视图
                    let subView = contentView.viewWithTag(200+i)
                    if subView?.isKindOfClass(UIButton.self) == true {
                        let url = NSURL(string: (imageModel?.content)!)
                        let btn = subView as! UIButton
                        btn.kf_setImageWithURL(url, forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                    
                    
                }
            }
        }
        //描述文字
        let subView = contentView.viewWithTag(400)
        if subView?.isKindOfClass(UILabel.self) == true {
            let descLabel = subView as! UILabel
            descLabel.text = model?.desc
        }
    }
    
    
    @IBAction func clickPlayBtn(sender: UIButton) {
        
        
    }
    
    @IBAction func clickDetailBtn(sender: UIButton) {
        
        
    }
    
    @IBAction func clickSceneBtn(sender: UIButton) {
        
        
        
    }
    
    class func createSpecialCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withListModel listModel: CBRecommendWidgetListModel)->CBSpecialCell{
        let cellID = "specialCellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? CBSpecialCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBSpecialCell", owner: nil, options: nil).last as? CBSpecialCell
        }
        cell?.model = listModel
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
