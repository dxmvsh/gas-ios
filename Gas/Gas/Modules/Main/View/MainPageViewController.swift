//
//  MainPageViewController.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

class MainPageViewController: BaseViewController {
    
    private let analyticsView: UIViewController
    private let accountInfoView: UIViewController
    
    init(analyticsView: UIViewController,
         accountInfoView: UIViewController) {
        self.analyticsView = analyticsView
        self.accountInfoView = accountInfoView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [analyticsView, accountInfoView].forEach {
            view.addSubview($0.view)
            $0.view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            analyticsView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            analyticsView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGuidance.offset),
            analyticsView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            analyticsView.view.heightAnchor.constraint(equalToConstant: 250),
            
            accountInfoView.view.topAnchor.constraint(equalTo: analyticsView.view.bottomAnchor),
            accountInfoView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offset),
            accountInfoView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offset),
            accountInfoView.view.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
}
