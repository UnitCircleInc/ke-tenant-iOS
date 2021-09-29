//
//  UnitPermissionsCard.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-16.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class UnitPermissionsCard: UIView {
    @IBOutlet var UnitPermissionsView: UIView!
    @IBOutlet weak var permissionsImage1: UIImageView!
    @IBOutlet weak var permissionsImage2: UIImageView!
    @IBOutlet weak var permissionsName1: UILabel!
    @IBOutlet weak var permissionsName2: UILabel!
    @IBOutlet weak var permissionsRelation1: UILabel!
    @IBOutlet weak var permissionsRelation2: UILabel!
    @IBOutlet weak var permissionsDate1: UILabel!
    @IBOutlet weak var permissionsDate2: UILabel!
    @IBOutlet weak var permissionsAddButton: UIButton!
    @IBOutlet weak var permissionsEditButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    
    private func commonInit() {
        Bundle.main.loadNibNamed("UnitPermissionsCard", owner: self, options: nil)
        addSubview(UnitPermissionsView)
        UnitPermissionsView.frame = self.bounds
        UnitPermissionsView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
