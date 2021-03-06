//
//  MainNoBackCell.swift
//  AppCard
//
//  Created by N17430 on 2021/02/06.
//

import UIKit

class MainNoBackCell: UITableViewCell {
    let HEIGHT0_ANCHOR_CONNECT = UILayoutPriority(999)
    let HEIGHT0_ANCHOR_BREAK = UILayoutPriority(240)
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentV: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleHeight0: NSLayoutConstraint!
    @IBOutlet weak var subTitle: UIButton!
    @IBOutlet weak var subTitleHeight0: NSLayoutConstraint!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var rightImgWidth0: NSLayoutConstraint!
    
    
    // MARK: Cell Config
    static func config(
        delegateTargetTo viewController: MainViewController?,
        _ tableView: UITableView,
        cellForItemAt indexPath: IndexPath,
        dataSource ds: Main.List) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainNoBackCell", for: indexPath) as? MainNoBackCell,
              let ele: Main.ListElement = ds.object(indexOf: indexPath.row),
              let d: Main.ListElement.Display = ele.display
        else {return UITableViewCell()}
        
        if let val = d.title, val.count > 0{
            cell.titleHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.title.text = val
        }
        else{ cell.titleHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        if let val = d.subTitle, val.count > 0{
            cell.subTitleHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.subTitle.setTitle(val, for: .normal)
        }
        else{ cell.subTitleHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        if let val = d.rightImgData{
            cell.rightImgWidth0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.rightImg.image = UIImage(data: val)
        }
        else{ cell.rightImgWidth0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
