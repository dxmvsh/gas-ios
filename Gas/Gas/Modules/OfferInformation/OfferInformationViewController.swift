//
//  OfferInformationViewController.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit
import WebKit

class OfferInformationViewController: BaseViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let webView = WKWebView()
    private let offerConfirmationView = OfferConfirmationView()
    
    var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        title = Text.publicOffer
        setupViews()
        let url = URL(string: "http://130.61.58.200/api/common/public-offer/")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    private func setupViews() {
        [scrollView, offerConfirmationView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        scrollView.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        offerConfirmationView.completion = { [weak self] in
            self?.didTapContinue()
        }
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: offerConfirmationView.topAnchor),
            
            offerConfirmationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            offerConfirmationView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            offerConfirmationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            offerConfirmationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func didTapContinue() {
        completion?()
    }
    
}
