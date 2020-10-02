//
//  HomeTitleLabel.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

@IBDesignable
class HomeTitleLabel: UILabel {

    var originalFontSize : CGFloat? = nil
    @IBInspectable var shrinkTo : CGFloat = 24

    private func getAnimationDuration(notification: NSNotification?) -> Double {
        if let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            return duration
        } else {
            return 0.3
        }
    }
    
    private func animate(to size: CGFloat, duration: Double) {
        let steps = Int(60 * duration) // 60fps
        let frameDuration = duration / Double(steps)
        let startingSize = self.font.pointSize
        let delta = size - self.font.pointSize
        
        for i in 0..<steps {
            let delay = Double(i) * frameDuration
            let newSize = startingSize + (delta / CGFloat(steps) * CGFloat(i))
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.font = UIFont(name: self.font.familyName, size: newSize)
            }
        }
    }
    
    func shrink(notification: NSNotification? = nil, activate layout: NSLayoutConstraint) {
        if (originalFontSize == nil) { originalFontSize = self.font.pointSize }
        let duration = getAnimationDuration(notification: notification)
        animate(to: shrinkTo, duration: duration)
        UIView.animate(withDuration: duration) {
            layout.isActive = true
            self.superview?.layoutIfNeeded()
        }
    }
    
    func expand(notification: NSNotification? = nil, disactivate layout: NSLayoutConstraint) {
        let duration = getAnimationDuration(notification: notification)
        animate(to: originalFontSize ?? 64, duration: duration)
        originalFontSize = nil
        UIView.animate(withDuration: duration) {
            layout.isActive = false
            self.superview?.layoutIfNeeded()
        }
    }
    
   
}
