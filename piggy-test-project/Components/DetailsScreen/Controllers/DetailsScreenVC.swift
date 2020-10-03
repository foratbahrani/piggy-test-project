//
//  DetailsScreenVC.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٣/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

class DetailsScreenVC: UIViewController {

    @IBOutlet var header: ShadowView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var asinCodeLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    
    var ASIN : String = "N/A"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHero()
        asinCodeLabel.text = ASIN
    }
    
    @IBAction func BackButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
