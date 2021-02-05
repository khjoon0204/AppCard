//
//  CALayer+Extension.swift
//  main
//
//  Created by N17430 on 2020/04/16.
//  Copyright © 2020 interpark-int. All rights reserved.
//


import Foundation
import UIKit

extension CALayer{
    @IBInspectable var borderUIColor : UIColor? {
        set (newValue) {
            self.borderColor = (newValue ?? UIColor.clear).cgColor
        }
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
    
    @objc func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
}
