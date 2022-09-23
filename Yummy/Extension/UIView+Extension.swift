//
//  UIView+Extension.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 15.09.2022.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
