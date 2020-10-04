//
//  HomeSearchField.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

@IBDesignable
class HomeSearchField: UITextField {
    
    @IBInspectable var cornerRadius : CGFloat = 32 { didSet { self.layer.cornerRadius = self.cornerRadius } }
    @IBInspectable var padding : CGFloat = 24
    @IBInspectable var isTitned : Bool = false { didSet { setIconTint() } }
    
    // magnifier icon, its constraints and tap
    let magnifierIcon : UIButton = UIButton(type: .custom)
    var tapGesture : UITapGestureRecognizer? = nil
    var trailingEdge : NSLayoutConstraint? = nil
    var centerYLayout : NSLayoutConstraint? = nil
    var heightLayout : NSLayoutConstraint? = nil
    var widthLayout : NSLayoutConstraint? = nil

    // textfield padding
    var edgeInsets : UIEdgeInsets {
        UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding * 2 + self.bounds.height / 2)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        addMagnifierIcon()
        self.layer.cornerRadius = self.cornerRadius
    }
    
    @objc private func onMagnifierIconTouchUpInside() {
        _ = self.delegate?.textFieldShouldReturn?(self)
    }
    
}

extension HomeSearchField {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
    private func setIconTint() {
        magnifierIcon.tintColor = isTitned ? #colorLiteral(red: 0.9215686275, green: 0.6156862745, blue: 0.7490196078, alpha: 1) : .secondaryLabel
    }
    
    private func addMagnifierIcon() {
        // add only if not already added.
        if (magnifierIcon.superview != nil) { return }
        
        // set icon image and add it to the textfield
        setIconTint()
        magnifierIcon.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        self.addSubview(magnifierIcon)
        
        // set onClick for button
        magnifierIcon.addTarget(self, action: #selector(onMagnifierIconTouchUpInside), for: .touchUpInside)
        
        // from here on, the rest is setting constraints of the magnifier icon
        magnifierIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Trailing Padding
        if let trailingEdge = trailingEdge {
            self.removeConstraints([ trailingEdge])
        }
        trailingEdge = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: magnifierIcon, attribute: .trailing, multiplier: 1, constant: 16)
        self.addConstraint(trailingEdge!)

        // Center Vertically
        if (centerYLayout == nil) {
             centerYLayout = NSLayoutConstraint(item: magnifierIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            self.addConstraint(centerYLayout!)
        }
       
        // Height
        if (heightLayout == nil) {
            heightLayout = NSLayoutConstraint(item: magnifierIcon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0)
            self.addConstraint(heightLayout!)
        }
        
        // Width
        if (widthLayout == nil) {
            widthLayout = NSLayoutConstraint(item: magnifierIcon, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0)
            self.addConstraint(widthLayout!)
        }
    }
}
