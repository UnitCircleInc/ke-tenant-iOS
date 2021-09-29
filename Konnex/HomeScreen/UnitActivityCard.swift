//
//  UnitActivityCard.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-16.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class UnitActivityCard: UIView {
    @IBOutlet var UnitActivityCardView: UIView!
    
    @IBOutlet weak var activityName1: UILabel!
    @IBOutlet weak var activityName2: UILabel!
    @IBOutlet weak var activityName3: UILabel!
    @IBOutlet weak var activityName4: UILabel!
    @IBOutlet weak var activityStatus1: UILabel!
    @IBOutlet weak var activityStatus2: UILabel!
    @IBOutlet weak var activityStatus3: UILabel!
    @IBOutlet weak var activityStatus4: UILabel!
    @IBOutlet weak var activityTimeStamp1: UILabel!
    @IBOutlet weak var activityTimeStamp2: UILabel!
    @IBOutlet weak var activityTimeStamp3: UILabel!
    @IBOutlet weak var activityTimeStamp4: UILabel!
    @IBOutlet weak var activityMoreButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("UnitActivityCard", owner: self, options: nil)
        addSubview(UnitActivityCardView)
        UnitActivityCardView.frame = self.bounds
        UnitActivityCardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
