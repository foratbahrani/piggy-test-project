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
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var noImageLabel: UILabel!
    @IBOutlet var productTitleLabel: UILabel!
    
    // json data received from API
    var data : JSON? = nil { didSet { initialize() } }
    
    func initialize() {
        guard let data = data else {
            // no data, reset
            productImageView.image = nil
            productTitleLabel.text = "N/A"
            self.contentView.showSkeleton()
            return
        }
        // hide skeleton and show title
        self.contentView.hideSkeleton()
        productTitleLabel.text = data["title"].string

        // get image url
        let url = data["imageUrl"].string ?? ""
        if (url.count == 0) {
            // no image, show a not-found image
            noImageLabel.isHidden = false
            return
        } else {
            // show skeleton ONLY for image view
            productImageView.showSkeleton()
            noImageLabel.isHidden = true
        }
        
        // http request to get the image
        AF.request(url).responseData { (response) in
            // check if the reusable cell is still showing the same product
            if (self.data?["imageUrl"].string != data["imageUrl"].string) {
                return // this cell is reused for other data
            }
            
            // if error, retry in 3 seconds
            if (response.error != nil) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.initialize()
                }
                return
            }

            // set image
            let image = UIImage(data: response.data ?? Data())
            self.productImageView.image = image
            self.productImageView.hideSkeleton()
        }
    }

}
