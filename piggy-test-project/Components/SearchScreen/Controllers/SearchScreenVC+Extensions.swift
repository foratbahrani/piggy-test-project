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
        AF.request("https://jsonplaceholder.typicode.com/photos").responseJSON { (response) in
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


extension SearchScreenVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(for: textField.text)
        textField.endEditing(true)
        return true
    }
}
