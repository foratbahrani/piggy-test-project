//
//  SearchScreenVC+Extensions.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٣/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SkeletonView

extension SearchScreenVC {
    
    func registerCells() {
        let cell = UINib(nibName: "SearchResultsCell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "SearchResultsCell")
    }
    
    func setupHero() {
        self.searchField.hero.id = "searchField"
        self.collectionView.hero.modifiers = [.fade, .translate(y: 400)]
    }
    
    func search(for query: String?) {
        guard let query = query, query.count > 0 else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        for cell in (collectionView.visibleCells as! [SearchResultsCell]) { cell.data = nil }
        self.view.showSkeleton()
        let headers = [
            "x-rapidapi-host": "amazon-price1.p.rapidapi.com",
            "x-rapidapi-key": "2769e9277emsh941a83c9cf67f61p187952jsn99e25f798af6"
        ]
        let url = "https://amazon-price1.p.rapidapi.com/search?keywords=\(query)&marketplace=US".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        AF.request(url ?? "", method: .get, parameters: nil, headers: HTTPHeaders(headers)).responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            } else {
                do {
                    let json = try JSON(data: response.data ?? Data())
                    self.data = json.array ?? []
                    self.view.hideSkeleton()
                } catch let err {
                    self.searchError(error: err.localizedDescription)
                }
            }
        }
    }
    
    fileprivate func searchError(error: String) {
        data = []
        print(error)
    }
}

// MARK: Textfield Delegate
extension SearchScreenVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(for: textField.text)
        textField.endEditing(true)
        return true
    }
}

// MARK: Collection View
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
    
    // collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gap : CGFloat = 16
        let inset : CGFloat = 32
        let cellsPerRow : CGFloat = 2
        let cellPerimeter = (collectionView.bounds.size.width / cellsPerRow) - (gap / cellsPerRow) - (inset / cellsPerRow)
        return CGSize(width: cellPerimeter, height: cellPerimeter)
    }
    
    // show asin when a product is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ASIN = data[indexPath.row]["ASIN"].string
        self.performSegue(withIdentifier: "showDetails", sender: ASIN)
    }
    
}
