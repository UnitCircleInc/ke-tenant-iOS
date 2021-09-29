//
//  UnitSummaryCard.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-16.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class UnitSummaryCard: UIView {
    @IBOutlet var UnitSummaryCardView: UIView!
    
    @IBOutlet weak var unitImage: UIImageView!
    @IBOutlet weak var unitName: UILabel!
    @IBOutlet weak var unitLocation: UILabel!
    @IBOutlet weak var unlockText: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("UnitSummaryCard", owner: self, options: nil)
        addSubview(UnitSummaryCardView)
        UnitSummaryCardView.frame = self.bounds
        UnitSummaryCardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
