//
//  MainNotiCell.swift
//  AppCard
//
//  Created by N17430 on 2021/02/06.
//

import UIKit

class MainNotiCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentV: UIView!
    
    // MARK: Cell Config
    static func config(
        delegateTargetTo viewController: MainViewController?,
        _ tableView: UITableView,
        cellForItemAt indexPath: IndexPath,
        dataSource ds: Main.List) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainNotiCell", for: indexPath) as? MainNotiCell else {return UITableViewCell()}
        // configuration..
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
