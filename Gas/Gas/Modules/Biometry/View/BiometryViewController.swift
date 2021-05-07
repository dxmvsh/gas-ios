//
//  BiometryViewController.swift
//  Gas
//
//  Created by Strong on 4/29/21.
//

import UIKit

fileprivate enum Constants {
    static let imageSize: CGFloat = 48
}

class BiometryViewController: BaseViewController {
    
    var output: BiometryViewOutput?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = LayoutGuidance.offsetHalf
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.biometry.image
        return imageView
    }()
    
    private let biometryTitleLabel: UILabel = LabelFactory.buildTitleLabel().with(text: Text.setSignInByFaceid)
    private let biometrySubtitleLabel: UILabel = LabelFactory.buildSubtitleLabel().with(text: Text.signInByFaceidIsSecure).with(numberOfLines: 0)
    
    private let primaryButton = Button.makePrimary(title: Text.setUp)
    private let secondaryButton = Button.makeSecondary(title: Text.skip)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        
        setupViews()
        addHandlers()
    }
    
    private func setupViews() {
        [imageView, biometryTitleLabel, biometrySubtitleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        [stackView, primaryButton, secondaryButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -LayoutGuidance.offset),
            
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            
            primaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            primaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            primaryButton.bottomAnchor.constraint(equalTo: secondaryButton.topAnchor, constant: -LayoutGuidance.offset),
            primaryButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
            
            secondaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            secondaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            secondaryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutGuidance.offset),
            secondaryButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
        ])
    }
    
    private func addHandlers() {
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func primaryButtonTapped() {
        
    }
    
    @objc
    private func secondaryButtonTapped() {
        
    }
    
}
