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
    var searchFor : String? = nil
    var data : [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHero()
        registerCells()
        hideKeyboardOnTap()
        self.searchField.text = searchFor
        search(for: searchFor)
        self.view.showSkeleton()
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func refreshButtonTouchUpInside(_ sender: Any) {
        self.search(for: searchField.text)
    }
    
}


extension SearchScreenVC : UICollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SearchResultsCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultsCell", for: indexPath) as! SearchResultsCell
        cell.data = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gap : CGFloat = 16
        let inset : CGFloat = 32
        let cellsPerRow : CGFloat = 2
        let perimeter = (collectionView.bounds.size.width / cellsPerRow) - (gap / cellsPerRow) - (inset / cellsPerRow)
        return CGSize(width: perimeter, height: perimeter)
    }
    
    
}
