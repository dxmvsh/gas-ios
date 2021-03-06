//
//  ResultViewController.swift
//  Gas
//
//  Created by Strong on 4/29/21.
//

import UIKit

fileprivate enum Constants {
    static let imageSize: CGFloat = 55
}

class ResultViewController: BaseViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = LayoutGuidance.offset
        return stackView
    }()
    
    private let resultTitleLabel = LabelFactory.buildTitleLabel().with(alignment: .center)
    private let resultSubtiteLabel = LabelFactory.buildSubtitleLabel().with(numberOfLines: 0).with(alignment: .center)
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        setupBackButton()
        
        setupViews()
    }
    
    private func setupViews() {
        [imageView, resultTitleLabel, resultSubtiteLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setSuccessState(title: String? = Text.congrats,
                         subtitle: String? = Text.youRegisteredSuccessfully,
                         image: UIImage? = Asset.rpSuccess.image) {
        resultTitleLabel.text = title
        resultSubtiteLabel.text = subtitle
        imageView.image = image
    }
    
    func setFailureState(title: String? = Text.congrats,
                         subtitle: String? = Text.youRegisteredSuccessfully,
                         image: UIImage? = Asset.rpSuccess.image) {
        resultTitleLabel.text = title
        resultSubtiteLabel.text = subtitle
        imageView.image = image
    }
    
}
