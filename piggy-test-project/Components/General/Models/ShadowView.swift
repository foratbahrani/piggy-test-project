//
//  ShadowView.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: RoundedView {

    @IBInspectable var shadowColor : UIColor? = nil { didSet { updateShadow()} }
    @IBInspectable var shadowRadius : CGFloat = 0 { didSet { updateShadow()} }
    @IBInspectable var shadowOpacity : Float = 0 { didSet { updateShadow()} }
    @IBInspectable var shadowX : CGFloat = 0 { didSet { updateShadow()} }
    @IBInspectable var shadowY : CGFloat = 0 { didSet { updateShadow()} }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override func commonInit() {
        super.commonInit()
        updateShadow()
    }
    
    func updateShadow() {
        self.layer.shadowColor = shadowColor?.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
    }

}
