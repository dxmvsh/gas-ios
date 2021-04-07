//
//  InitialViewController.swift
//  Gas
//
//  Created by Strong on 4/1/21.
//

import UIKit

fileprivate enum Constants {
    static let imageWidth: CGFloat = 258
    static let imageHeight: CGFloat = 219
}

class InitialViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutGuidance.offset
        stackView.alignment = .center
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.initialImage.image
        return view
    }()
    
    private let titleLabel = LabelFactory.buildTitleLabel()
        .with(text: Text.welcome)
    
    private let subtitleLabel = LabelFactory.buildSubtitleLabel()
        .with(text: Text.signInOrSignUpToContinue)
                                            .with(numberOfLines: 0)
                                            .with(alignment: .center)
    
    private let registrationButton = Button.makePrimary(title: Text.registration)
    private let signInButton = Button.makeSecondary(title: Text.signInToApp)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setConstraints()
        configureButtons()
        view.backgroundColor = Color.background
    }
    
    private func addViews() {
        view.addSubview(stackView)
        let subtitleButtonSpacer = SpaceFactory.build(with: CGSize(width: stackView.frame.width, height: 32))
        let imageTitleSpacer = SpaceFactory.build(with: CGSize(width: stackView.frame.width, height: 40))
        [imageView, imageTitleSpacer, titleLabel, subtitleLabel, subtitleButtonSpacer, registrationButton, signInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetHalf),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetHalf),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            registrationButton.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
            
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset)
        ])
    }
    
    private func configureButtons() {
        registrationButton.addTarget(self, action: #selector(registrationTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    @objc
    private func registrationTapped() {
        print("registrationTapped")
    }
    
    @objc
    private func signInTapped() {
        print("signInTapped")
    }
}
