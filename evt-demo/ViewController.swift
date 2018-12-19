//
//  ViewController.swift
//  evt-demo
//
//  Created by Fei Liu on 19.12.18.
//  Copyright © 2018 Evt. All rights reserved.
//

import UIKit
import WebKit

extension ViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let response = message.body as? String else { return }
        print(response)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // calling createKeyPair from javascript, the result will be sent back
        webView.evaluateJavaScript("createKeyPair()", completionHandler: nil)

    }
}

class ViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentController = WKUserContentController()
        
        // register a message handler named "ios", calling `webkit.messageHandlers.callback.postMessage(data)`
        // will pass the `data` back to native
        contentController.add(self, name: "ios")
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.frame = CGRect(x:0, y:0, width: super.view.frame.width, height: super.view.frame.height * 0.5)
        
        // load custom index.html, in which the javascript sdk evtjs is available
        let url = Bundle.main.url(forResource: "index", withExtension: "html")
        webView.loadFileURL(url!, allowingReadAccessTo: url!)
        
        view.addSubview(webView)
       
    }

}

