//
//  ActivityListTableViewCell.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-22.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class ActivityListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(nameText: String, statusText: String, timeStampText: String) {
        nameLabel.text = nameText
        statusLabel.text = statusText
        timeStampLabel.text = timeStampText
    }
}
