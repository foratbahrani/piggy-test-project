//
//  SearchScreenVC.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٢/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit
import SkeletonView
import Hero
import SwiftyJSON

class SearchScreenVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var searchField: HomeSearchField!
    @IBOutlet var refreshButton: UIButton!
    
    var query : String? = nil
    var data : [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHero()
        registerCells()
        self.searchField.text = query
        search(for: query)
        self.view.showSkeleton()
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func refreshButtonTouchUpInside(_ sender: Any) {
        self.search(for: searchField.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is DetailsScreenVC && sender is String) {
            (segue.destination as! DetailsScreenVC).ASIN = sender as! String
        }
    }
}


