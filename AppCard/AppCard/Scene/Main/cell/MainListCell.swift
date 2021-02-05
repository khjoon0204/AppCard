//
//  MainListCell.swift
//  AppCard
//
//  Created by N17430 on 2021/02/05.
//

import UIKit

class MainListCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentV: UIView!
    @IBOutlet weak var headerTitle: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var labelText: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var labelImg: UIImageView!
    @IBOutlet weak var centerImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 10, y: 10, blur: 8, spread: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
