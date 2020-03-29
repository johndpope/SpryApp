//
//  TrueUserPropertyTableViewCell.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 13/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import Foundation
import UIKit

class TrueUserPropertyTableViewCell: UITableViewCell {
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    
    class func reuseIdentifier() -> String {
        return "TrueUserPropertyTableViewCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
