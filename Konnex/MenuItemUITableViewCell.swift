//
//  MenuItemUITableViewCell.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-20.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class MenuItemUITableViewCell: UITableViewCell {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // active menu option should be coloured 
//        if selected {
//            contentView.backgroundColor = UIColor.blue
//        } else {
//            contentView.backgroundColor = UIColor.green
//        }
    }
    
    public func configure(_ text: String, image: UIImage) {
        menuImage.image = image
        menuName.text = text
    }
    
    public func isActive (_ selected: Bool) {
        setSelected(selected, animated: false)
    }
}
