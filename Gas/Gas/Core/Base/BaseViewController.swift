//
//  BaseViewController.swift
//  Gas
//
//  Created by Strong on 4/16/21.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let titleLabel = LabelFactory.buildTitleLabel()
        .with(numberOfLines: 0)
        .with(alignment: .center)
    
    let subtitleLabel = LabelFactory.buildSubtitleLabel()
        .with(numberOfLines: 0)
        .with(alignment: .center)
    
    lazy var backButtonTapHandler: (() -> Void)? = { [weak self] in
        self?.navigationController?.popViewController(animated: true)
    }
    
    var contactButtonTapHandler: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
    }
    
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
    
    func addTitleAndSubtitleLabels(title: String = "", subtitle: String = "") {
        [titleLabel, subtitleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        titleLabel.text = title
        subtitleLabel.text = subtitle
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGuidance.offsetDouble),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
        ])
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
