//
//  SearchResultsCell.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on ٣/١٠/٢٠٢٠.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SearchResultsCell: UICollectionViewCell {
    
    var indexPath : IndexPath = IndexPath(item: 0, section: 0)
    var data : JSON? = nil { didSet { load() } }
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productTitleLabel: UILabel!
    
    func load() {
        guard let data = data else {
            productImageView.image = nil
            productTitleLabel.text = "N/A"
            self.contentView.showSkeleton()
            return
        }
        self.contentView.hideSkeleton()
        productTitleLabel.text = data["title"].string
        productImageView.showSkeleton()
        productImageView.backgroundColor = .skeletonDefault
        let url = data["url"].string ?? ""
        AF.request(url).responseData { (response) in
            if (self.data?["url"].string != data["url"].string) {
                return // cell reused for other data
            }
            
            if (response.error != nil) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.load()
                }
                return
            }

            let image = UIImage(data: response.data ?? Data())
            self.productImageView.hideSkeleton()
            UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.productImageView.image = image
            }, completion: nil)
        }
    }

}
