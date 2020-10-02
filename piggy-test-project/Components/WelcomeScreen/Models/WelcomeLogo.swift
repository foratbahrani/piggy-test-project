//
//  WelcomeLogo.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

class WelcomeLogo: UIImageView {

    func animate(completion: @escaping (()->())) {
        UIView.animate(withDuration: 0.4, delay: 0.5, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }) { (_) in
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveLinear, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
            }) { (_) in
                completion()
            }
        }
    }

}
