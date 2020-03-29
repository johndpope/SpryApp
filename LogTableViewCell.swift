//
//  LogTableViewCell.swift
//  Spry
//
//  Created by OKORIE CHINAZA on 13/04/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import Foundation
import UIKit

class LogTableViewCell: UITableViewCell {
    @IBOutlet weak var errorCodeLabel: UILabel!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    @IBOutlet weak var errorDateLabel: UILabel!
    
    class func reuseIdentifier() -> String {
        return "LogTableViewCellIdentifier"
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
