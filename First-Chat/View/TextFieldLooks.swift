//
//  Looks.swift
//  First-Chat
//
//  Created by Neven on 08/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

@IBDesignable
class TextFieldLooks: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor!.cgColor
        }
    }

    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            let rawValue = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let placeHolder = NSAttributedString(string: rawValue, attributes: [.foregroundColor : placeholderColor!])
            attributedPlaceholder = placeHolder
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
}




