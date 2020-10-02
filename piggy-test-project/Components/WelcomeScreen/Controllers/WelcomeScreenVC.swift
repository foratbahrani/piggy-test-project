//
//  WelcomeScreenVC.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

class WelcomeScreenVC: UIViewController {

    @IBOutlet var LogoImageView: WelcomeLogo!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // animate the logo
        LogoImageView.animate(completion: {
            // load home screen
            self.performSegue(withIdentifier: "showHome", sender: nil)
        })
    }

}
