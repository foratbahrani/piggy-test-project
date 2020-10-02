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
    let searchIcon : UIImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    var trailingEdge : NSLayoutConstraint? = nil
    var centerYLayout : NSLayoutConstraint? = nil
    var heightLayout : NSLayoutConstraint? = nil
    var widthLayout : NSLayoutConstraint? = nil

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
        addSearchIcon()
        self.layer.cornerRadius = self.cornerRadius
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
    
    private func addSearchIcon() {
        if (searchIcon.superview != nil) { return }
        
        searchIcon.tintColor = .secondaryLabel
        self.addSubview(searchIcon)
        
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Trailing Padding
        if let trailingEdge = trailingEdge {
            self.removeConstraints([ trailingEdge])
        }
        trailingEdge = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: searchIcon, attribute: .trailing, multiplier: 1, constant: 16)
        self.addConstraint(trailingEdge!)

        // Center Vertically
        if (centerYLayout == nil) {
             centerYLayout = NSLayoutConstraint(item: searchIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            self.addConstraint(centerYLayout!)
        }
       
        // Height
        if (heightLayout == nil) {
            heightLayout = NSLayoutConstraint(item: searchIcon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0)
            self.addConstraint(heightLayout!)
        }
        
        // Width
        if (widthLayout == nil) {
            widthLayout = NSLayoutConstraint(item: searchIcon, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0)
            self.addConstraint(widthLayout!)
        }
    }
}
