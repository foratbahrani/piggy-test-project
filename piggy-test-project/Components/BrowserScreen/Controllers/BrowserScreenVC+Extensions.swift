//
//  BrowserScreenVC+Extensions.swift
//  piggy-test-project
//
//  Created by Forat Bahrani on 10/4/20.
//  Copyright © 2020 Forat Bahrani. All rights reserved.
//

import UIKit
import WebKit


// MARK: Web View
extension BrowserScreenVC: WKNavigationDelegate {
    
    func setupWebview() {
        progressBar.progress = 0
        progressBar.gradientColors = [#colorLiteral(red: 0.9215686275, green: 0.6156862745, blue: 0.7490196078, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.load(URLRequest(url: URL(string: "https://amazon.com")!))
    }
    
    // enables/disables back and forward button.
    func handleNavigationButtons() {
        // back button
        if webView.canGoBack {
            backButton.tintColor = #colorLiteral(red: 0.9215686275, green: 0.6156862745, blue: 0.7490196078, alpha: 1)
            backButton.isEnabled = true
        } else {
            backButton.tintColor = .tertiaryLabel
            backButton.isEnabled = false
        }
        // forward button
        if webView.canGoForward {
            forwardButton.tintColor = #colorLiteral(red: 0.9215686275, green: 0.6156862745, blue: 0.7490196078, alpha: 1)
            forwardButton.isEnabled = true
        } else {
            forwardButton.tintColor = .tertiaryLabel
            forwardButton.isEnabled = false
        }
    }
    
    // checks for an ASIN code in webpage using regex and if found, shows it.
    func searchASIN(webView: WKWebView) {
        let url = webView.url?.absoluteString ?? ""
        let range = NSRange(location: 0, length: url.utf16.count)
        let regex = try! NSRegularExpression(pattern: "(?:[/dp/]|$)([A-Z0-9]{10})")
        let results = regex.matches(in: url, options: [], range: range)
        guard results.count > 0 else { return }
        let ASIN = results.map {
            String(url[Range($0.range, in: url)!])
            }[0].replacingOccurrences(of: "/", with: "")
        self.performSegue(withIdentifier: "showDetails", sender: ASIN)
    }
    
    // finds the current progress of webview
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressBar.setProgress(Float(webView.estimatedProgress) , animated: true)
            // webview is hidden the first time (this fixes an appearence bug in dark mode)
            if webView.alpha == 0 && Float(webView.estimatedProgress) > 0.75 {
                UIView.animate(withDuration: 0.3) {
                    self.webView.alpha = 1
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressBar.setProgress(1, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + progressBar.animationDuration) {
            UIView.animate(withDuration: 0.3) {
                self.progressBar.alpha = 0
            }
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.progressBar.alpha = 1
        handleNavigationButtons()
        searchASIN(webView: webView)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIView.animate(withDuration: 0.3) {
            self.progressBar.alpha = 0
        }
    }
    
    
    
}

// MARK: Textfield Delegate
extension BrowserScreenVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        guard let query = textField.text, query.count > 0 else { return true }
        let url = "https://www.amazon.com/s?k=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        webView.load(URLRequest(url: URL(string: url!)!))
        return true
    }
    
}
