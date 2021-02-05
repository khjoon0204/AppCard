//
//  MainListCell.swift
//  AppCard
//
//  Created by N17430 on 2021/02/05.
//

import UIKit

class MainListCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var headerTitle: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var labelText: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    
    @IBOutlet weak var labelImg: UIImageView!
    @IBOutlet weak var centerImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
