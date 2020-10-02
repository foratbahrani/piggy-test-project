//
//  HomeVC+Extensions.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import Foundation
import UIKit

extension HomeVC {
    
    func animate() {
        
        let views = [piggyIconImageView, titleLabel, searchField, orStackView, useBrowserButton]
        
        for i in 0..<views.count {
            // hide & move down
            views[i]?.alpha = 0
            views[i]?.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 32)

            // fade in
            let delay =  0.1 * Double(i)
            UIView.animate(withDuration: 0.4, delay: delay, options: .curveEaseOut, animations: {
                views[i]?.alpha = 1
                views[i]?.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupHero() {
        self.searchField.hero.id = "searchField"
        self.piggyIconImageView.hero.modifiers = [.translate(y: -100), .fade]
        self.titleLabel.hero.modifiers = [.translate(y: -100), .fade]
    }
    
}

// keyboard functions
extension HomeVC {
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        titleLabel.shrink(notification: notification, activate: titleLabelHeight)
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification){
//        titleLabel.expand(notification: notification, disactivate: titleLabelHeight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.destination is SearchScreenVC && sender is String) {
            (segue.destination as! SearchScreenVC).searchFor = sender as? String
        }
    }
    
}

extension HomeVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.performSegue(withIdentifier: "showSearch", sender: textField.text)
        return true
    }
    
}
