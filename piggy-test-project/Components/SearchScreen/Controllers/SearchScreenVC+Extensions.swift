//
//  SearchScreenVC+Extensions.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٣/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit

extension SearchScreenVC {
    func registerCells() {
        let cell = UINib(nibName: "SearchResultsCell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "SearchResultsCell")
    }
    
    func setupHero() {
        self.searchField.hero.id = "searchField"
    }
}
