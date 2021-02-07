//
//  MainListCell.swift
//  AppCard
//
//  Created by N17430 on 2021/02/05.
//

import UIKit

class MainListCell: UITableViewCell {
    let HEIGHT0_ANCHOR_CONNECT = UILayoutPriority(999)
    let HEIGHT0_ANCHOR_BREAK = UILayoutPriority(240)
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentV: UIView!
    @IBOutlet weak var headerTitle: UIButton!
    @IBOutlet weak var headerTitleHeight0: NSLayoutConstraint!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainTitleHeight0: NSLayoutConstraint!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var subTitleHeight0: NSLayoutConstraint!
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var dDayHeight0: NSLayoutConstraint!
    @IBOutlet weak var labelText: UIButton!
    @IBOutlet weak var labelTextHeight0: NSLayoutConstraint!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var labelImg: UIImageView!
    @IBOutlet weak var labelImgHeight0: NSLayoutConstraint!
    @IBOutlet weak var centerImg: UIImageView!
    @IBOutlet weak var centerImgHeight0: NSLayoutConstraint!
    let f = DateFormatter(withFormat: "yyyyMMddhhmmss")
    
    // MARK: Cell Config
    static func config(
        delegateTargetTo viewController: MainViewController?,
        _ tableView: UITableView,
        cellForItemAt indexPath: IndexPath,
        dataSource ds: Main.List) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainListCell", for: indexPath) as? MainListCell,
              let ele: Main.List.ListElement = ds.object(indexOf: indexPath.row),
              let d: Main.List.Display = ele.display
        else {return UITableViewCell()}
        
        // property set
        if let val = d.headerTitle{
            cell.headerTitleHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.headerTitle.setTitle(val, for: .normal)
        }
        else{ cell.headerTitleHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        if let val = d.mainTitle{
            cell.mainTitleHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.mainTitle.text = val
        }
        else{ cell.mainTitleHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        if let val = d.subTitle{
            cell.subTitleHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.subTitle.text = val
        }
        else{ cell.subTitleHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        if let val = ele.dDayDate,
           let dateDDay = cell.f.date(from: val),
           case let days = Calendar.current.dateComponents([.day], from: Date(), to: dateDDay)
        {
            cell.dDayHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.dDayLabel.text = "D - \(days.day ?? 0)"
        }
        else{ cell.dDayHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        if let val = d.labelText{
            cell.labelTextHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.labelText.setTitle(val, for: .normal)
        }
        else{ cell.labelTextHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        if cell.backImg.image == nil, let val = d.backImgData{
            cell.backImg.image = UIImage(data: val)
        }
        
        if let val = d.labelImgData{
            cell.labelImgHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.labelImg.image = UIImage(data: val)
        }
        else{ cell.labelImgHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        if let val = d.centerImgData{
            cell.centerImgHeight0.priority = cell.HEIGHT0_ANCHOR_BREAK
            cell.centerImg.image = UIImage(data: val)
        }
        else{ cell.centerImgHeight0.priority = cell.HEIGHT0_ANCHOR_CONNECT }
        
        // color
        if let val = d.mainColor{
            let color = UIColor(hex: val)
            cell.contentV.backgroundColor = color
        }
        
        if let val = d.fontColor{
            let color = UIColor(hex: val)
            cell.headerTitle.setTitleColor(color, for: .normal)
            cell.mainTitle.textColor = color
            cell.subTitle.textColor = color
            cell.labelText.setTitleColor(color, for: .normal)
        }
        
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 10, y: 20, blur: 20, spread: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
