//
//  PasscodeInputView.swift
//  Gas
//
//  Created by Strong on 4/26/21.
//

import UIKit

fileprivate enum Constants {
    static let placehoderChar = "•"
}

class PasscodeInputView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutGuidance.offsetAndHalf
        return stackView
    }()
    
    private var dotViews: [UIView] = []
    private let count: Int
    
    init(count: Int) {
        self.count = count
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        for _ in 0..<count {
            let dotView = UIView()
            dotView.translatesAutoresizingMaskIntoConstraints = false
            dotView.roundCorners(radius: 6)
            dotView.backgroundColor = Color.lineGray2
            dotViews.append(dotView)
            stackView.addArrangedSubview(dotView)
            NSLayoutConstraint.activate([
                dotView.widthAnchor.constraint(equalToConstant: 12),
                dotView.heightAnchor.constraint(equalToConstant: 12)
            ])
        }
        
        [stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func set(highlighted: Bool, at index: Int) {
        guard (0..<count).contains(index) else { return }
        dotViews[index].backgroundColor = highlighted ? Color.main : Color.lineGray2
    }
    
    func showErrorState() {
        for view in dotViews {
            view.backgroundColor = Color.red
        }
    }
    
    func showDefaultState() {
        for view in dotViews {
            view.backgroundColor = Color.lineGray2
        }
    }
}
