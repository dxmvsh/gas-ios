//
//  WebViewController.swift
//  Gas
//
//  Created by Strong on 5/21/21.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    private let webView = WKWebView()
    private let paymentService = PaymentService()
    private var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        setupViews()
        setupDownloadButton()
        
        webView.addShadow()
    }
    
    private func setupViews() {
        [webView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            webView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            webView.widthAnchor.constraint(equalToConstant: 325),
            webView.heightAnchor.constraint(equalToConstant: 390)
        ])
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setAndLoad(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    func setHtmlCode(htmlCode: String) {
        webView.loadHTMLString(htmlCode, baseURL: nil)
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
    
    func setupDownloadButton() {
        let contactButton = UIButton()
        contactButton.backgroundColor = .white
        contactButton.layer.cornerRadius = 10
        contactButton.addShadow()
        contactButton.addTarget(self, action: #selector(downloadTapped), for: .touchUpInside)
        
        let supportIcon = UIImageView(image: Asset.icondownload.image)
        supportIcon.contentMode = .scaleAspectFit
        contactButton.addSubview(supportIcon)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: contactButton)
        supportIcon.snp.makeConstraints { $0.center.equalToSuperview() }
        contactButton.snp.makeConstraints { $0.size.equalTo(36) }
    }
    
    @objc
    private func downloadTapped() {
        paymentService.getPayment(id: id) { [weak self] result in
            switch result {
            case .success(let url):
                let activity = UIActivityViewController(
                    activityItems: [url],
                    applicationActivities: nil)
                self?.present(activity, animated: true, completion: nil)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
