//
//  UIView+ViewVisibility.swift
//  LyricsApp
//
//  Created by Javier Sapia on 16/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit
import Foundation

extension UIView {

    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutConstraint.Attribute = .height) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = gone ? 0.0 : dimension
            self.layoutIfNeeded()
            self.isHidden = gone
        }
    }
    
}
