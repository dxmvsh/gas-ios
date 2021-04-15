//
//  BaseViewController.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    lazy var backButtonTapHandler: (() -> Void)? = { [weak self] in
        self?.navigationController?.popViewController(animated: true)
    }
    
    var contactButtonTapHandler: (() -> Void)? = nil
    
    func setupDefaultNavigationBarStyle() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setupBackButton() {
        let backButton = UIButton()
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 10
        backButton.addShadow()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        let closeImageIcon = UIImageView(image: Asset.nbBackIcon.image)
        closeImageIcon.contentMode = .scaleAspectFit
        closeImageIcon.tintColor = UIColor.darkGray
        backButton.addSubview(closeImageIcon)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        closeImageIcon.snp.makeConstraints { $0.center.equalToSuperview() }
        backButton.snp.makeConstraints { $0.size.equalTo(36) }
    }
    
    func setupContactSupportButton() {
        let contactButton = UIButton()
        contactButton.backgroundColor = .white
        contactButton.layer.cornerRadius = 10
        contactButton.addShadow()
        contactButton.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
        
        let supportIcon = UIImageView(image: Asset.nbSupportIcon.image)
        supportIcon.contentMode = .scaleAspectFit
        contactButton.addSubview(supportIcon)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: contactButton)
        supportIcon.snp.makeConstraints { $0.center.equalToSuperview() }
        contactButton.snp.makeConstraints { $0.size.equalTo(36) }
    }
    
    @objc
    private func backButtonTapped() {
        backButtonTapHandler?()
    }
    
    @objc
    private func contactButtonTapped() {
        contactButtonTapHandler?()
    }
}
