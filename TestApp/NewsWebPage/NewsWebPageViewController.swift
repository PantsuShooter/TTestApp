//
//   NewsWebPageViewController.swift
//  TestApp
//
//  Created by DeveloperMBP on 8/11/19.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Lottie

class NewsWebPageViewController : UIViewController, WKNavigationDelegate {
    
    // MARK: - Variables
    @IBOutlet private weak var newsWebView: WKWebView!
    @IBOutlet private weak var newsWebViewProgressView: UIProgressView!

    private var newsUrl:URL!
    private let animationView = AnimationView()
    
    private struct Constants {
        static let Progress = "estimatedProgress"
        static let AnimationName = "vui-animation"
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupLottieView()
        debugPrint("NewsWebPageViewController viewDidLoad")
    }
    
    deinit {
        newsWebView.removeObserver(self, forKeyPath: Constants.Progress)
    }
    
    // MARK: - Public
    public func urlToOpen(url:URL) {
        newsUrl = url
    }
    
    // MARK: - Private
    private func setupWebView() {
        let urlRequest = URLRequest(url: newsUrl)
        newsWebView.load(urlRequest)
        newsWebView.navigationDelegate = self
        newsWebView.addObserver(self, forKeyPath: Constants.Progress, options: .new, context: nil)
    }
    
    private func setupLottieView() {
        let animation = Animation.named(Constants.AnimationName)
        animationView.animation = animation
        animationView.frame = view.frame
        animationView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.97)
        animationView.loopMode = .loop
        newsWebView.addSubview(animationView)
        animationView.play()
    }
    
    // MARK: - Observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Constants.Progress {
            newsWebViewProgressView.progress = Float(newsWebView.estimatedProgress)
            
        }
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIView.animate(withDuration: 0.3, animations:  {
            self.animationView.alpha = 0
            self.newsWebViewProgressView.alpha = 0
        }) { (end) in
            self.animationView.stop()
        }
    }
}
