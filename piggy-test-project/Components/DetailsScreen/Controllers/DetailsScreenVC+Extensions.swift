//
//  DetailsScreenVC+Extensions.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٣/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

extension DetailsScreenVC {
    
    func setupHero() {
        self.header.hero.id = "header"
        self.header.hero.modifiers = [.fade]
        self.detailsLabel.hero.modifiers = [.fade, .translate(y: -200)]
        self.asinCodeLabel.hero.modifiers = [.fade, .translate(y: -200)]
    }
    
}
