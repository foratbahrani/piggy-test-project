//
//  UIViewController+Extensions.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٣/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func hideKeyboard() {
        self.view.endEditing(true)
    }
}
