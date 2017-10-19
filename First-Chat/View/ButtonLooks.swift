//
//  ButtonLooks.swift
//  First-Chat
//
//  Created by Neven on 13/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonLooks: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
