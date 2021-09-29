//
//  RadioButtonTableViewCell.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-19.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class RadioButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButtonLabel: UILabel!
    @IBOutlet weak var radioButtonIcon: UIImageView!
    
    private let checked = UIImage(named: "radio-on")
    private let unchecked = UIImage(named: "radio-off")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(_ text: String) {
        radioButtonLabel.text = text
    }
    
    public func isSelected(_ selected: Bool) {
        setSelected(selected, animated: false)
        let image = selected ? checked : unchecked
        radioButtonIcon.image = image
    }
    
}
