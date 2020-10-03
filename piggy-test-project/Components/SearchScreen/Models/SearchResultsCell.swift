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
    
    var data : JSON? = nil { didSet { load() } }
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var noImageLabel: UILabel!
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
        let url = data["imageUrl"].string ?? ""
        if (url.count == 0) {
            noImageLabel.isHidden = false
            return
        }
        noImageLabel.isHidden = true
        AF.request(url).responseData { (response) in
            if (self.data?["imageUrl"].string != data["imageUrl"].string) {
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
