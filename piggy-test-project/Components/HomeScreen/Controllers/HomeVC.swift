//
//  HomeVC.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit
import Hero

class HomeVC: UIViewController {
    
    @IBOutlet var piggyIconImageView: UIImageView!
    @IBOutlet var titleLabelHeight: NSLayoutConstraint!
    @IBOutlet var titleLabel: HomeTitleLabel!
    @IBOutlet var searchField: HomeSearchField!
    @IBOutlet var orStackView: UIStackView!
    @IBOutlet var useBrowserButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        animate()
        setupHero()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.destination is SearchScreenVC && sender is String) {
            (segue.destination as! SearchScreenVC).query = sender as? String
        }
    }
    
}
