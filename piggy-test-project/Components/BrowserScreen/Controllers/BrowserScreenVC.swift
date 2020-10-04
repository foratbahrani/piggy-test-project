//
//  BrowserScreenVC.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on 10/4/20.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit
import WebKit
import GradientProgressBar

class BrowserScreenVC: UIViewController {

    @IBOutlet var closeButton: UIButton!
    @IBOutlet var searchField: HomeSearchField!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var progressBar: GradientProgressBar!
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebview()
    }
    
    
    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonTouchUpInside(_ sender: Any) {
        webView.goForward()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.destination is DetailsScreenVC && sender is String) {
            (segue.destination as! DetailsScreenVC).ASIN = sender as! String
        }
    }
    
}


