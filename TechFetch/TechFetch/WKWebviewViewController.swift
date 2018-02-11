//
//  WKWebviewViewController.swift
//  TechFetch
//
//  Created by Jason Park on 2/11/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit
import WebKit

class WKWebviewViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webview.load(URLRequest(url: URL(string: url!)!))
    }


}
