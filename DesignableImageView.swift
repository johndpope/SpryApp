//
//  Spry
//
//  Created by OKORIE CHINAZA on 18/01/2018.
//  Copyright © 2018 Spry Enterprise. All rights reserved.
//

import UIKit

@IBDesignable public class DesignableImageView: SpringImageView {
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
