//
//  RoundedView.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var radius: CGFloat = 0 { didSet { commonInit() } }
    @IBInspectable var topRight: Bool = false { didSet { commonInit() } }
    @IBInspectable var topLeftt: Bool = false { didSet { commonInit() } }
    @IBInspectable var bottomRight: Bool = false { didSet { commonInit() } }
    @IBInspectable var bottomLeft: Bool = false { didSet { commonInit() } }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.layer.cornerRadius = radius
        var corners : CACornerMask = []
        if topLeftt { corners.insert(.layerMinXMinYCorner) }
        if topRight { corners.insert(.layerMaxXMinYCorner) }
        if bottomLeft { corners.insert(.layerMinXMaxYCorner) }
        if bottomRight { corners.insert(.layerMaxXMaxYCorner) }
        self.layer.maskedCorners = corners
    }
}
