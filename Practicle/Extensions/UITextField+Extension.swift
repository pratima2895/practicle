//
//  UITextField+Extension.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit

class UIAppTextField : UITextField {
    @IBInspectable var placeholderColor : UIColor = UIColor.systemGray {
        didSet {
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )
        }
    }
    
    override var placeholder: String? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )
        }
    }
}
