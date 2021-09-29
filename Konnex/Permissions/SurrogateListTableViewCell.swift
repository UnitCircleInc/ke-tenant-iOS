//
//  SurrogateListTableViewCell.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-23.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class SurrogateListTableViewCell: UITableViewCell {
    @IBOutlet weak var surrogateImage: UIImageView!
    @IBOutlet weak var surrogateName: UILabel!
    @IBOutlet weak var surrogateTimestamp: UILabel!
    @IBOutlet weak var surrogateEditButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(image: UIImage, name: String, timestamp: String) {
        surrogateImage.image = image
        surrogateName.text = name
        surrogateTimestamp.text = timestamp
    }
}
