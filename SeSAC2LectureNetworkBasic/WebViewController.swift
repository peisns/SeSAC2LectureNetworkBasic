//
//  WebViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
//    static var reuseIdentifier: String = String(describing: WebViewController.self) // "WebViewController"
    
    @IBOutlet weak var webSearchBar: UISearchBar!
    
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://google.com"
    override func viewDidLoad() {
        super.viewDidLoad()

        openWebPage(to: destinationURL)
        webSearchBar.delegate = self
    }
    
    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
        
        
    }
    
    
    
    
    func openWebPage(to url:String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(to: searchBar.text!)
        print(#function)
    }
}
