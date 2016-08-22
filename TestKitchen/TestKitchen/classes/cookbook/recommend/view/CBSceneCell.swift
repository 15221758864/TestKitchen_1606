//
//  CBSceneCell.swift
//  TestKitchen
//
//  Created by Ronie on 16/8/22.
//  Copyright © 2016年 Ronie. All rights reserved.
//

import UIKit

class CBSceneCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configTitle(title: String) {
        self.nameLabel.text = title
    }
    
    //创建cell的方法
    class func createSceneCell(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withListModel listModel: CBRecommendWidgetListModel)->CBSceneCell{
        let cellID = "sceneCellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)as? CBSceneCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBSceneCell", owner: nil, options: nil).last as? CBSceneCell
        }
        if let title = listModel.title {
            cell?.configTitle(title)
        }
        return cell!
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
