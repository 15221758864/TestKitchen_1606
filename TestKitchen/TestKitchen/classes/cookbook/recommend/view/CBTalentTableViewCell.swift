//
//  CBTalentTableViewCell.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/22.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CBTalentTableViewCell: UITableViewCell {

    @IBOutlet weak var fansLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var talentImageView: UIImageView!
    
    var dataArray: Array<CBRecommendWidgetDataModel>?{
        didSet{
            showData()
        }
    
    }
    
    func showData() {
        if dataArray?.count > 0 {
            let imageModel = dataArray![0]
            if imageModel.type == "image" {
                let url = NSURL(string: imageModel.content!)
                talentImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        if dataArray?.count > 1 {
            let nameModel = dataArray![1]
            if nameModel.type == "text" {
                nameLabel.text = nameModel.content
            }
        }
        //描述文字
        if dataArray?.count > 2 {
            let descModel = dataArray![2]
            if descModel.type == "text" {
                descLabel.text = descModel.content
            }
        }
        
        //粉丝数
        if dataArray?.count > 3 {
            let fansModel = dataArray![3]
            if fansModel.type == "text" {
                fansLabel.text = fansModel.content
            }
        }
    }
    
    //创建cell的方法
    class func createTalentCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withListModel listModel: CBRecommendWidgetListModel)->CBTalentTableViewCell{
        let cellID = "talentCellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)as? CBTalentTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBTalentTableViewCell", owner: nil, options: nil).last as? CBTalentTableViewCell
        }
        //indexPath.row     0      1      2
        //listModel.data  {0-3}  {4-7}  {8-11}
        if listModel.widget_data?.count >= indexPath.row*4+3 {
            let array = NSArray(array: listModel.widget_data!)
            let curArray = array.subarrayWithRange(NSMakeRange(indexPath.row*4, 4))
            cell?.dataArray = curArray as? Array<CBRecommendWidgetDataModel>
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
