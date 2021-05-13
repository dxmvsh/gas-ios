//
//  PaymentHistoryViewController.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

class PaymentHistoryViewController: UIViewController, PaymentHistoryViewInput {
    
    var output: PaymentHistoryViewOutput?
    var adapters: [PaymentHistoryCellAdapter] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let titleLabel = UILabel().with(textColor: Color.darkGray).with(font: .systemFont(ofSize: 18, weight: .medium)).with(text: "История")
    
    private let noPaymentsLabel = UILabel().with(font: .systemFont(ofSize: 16)).with(textColor: Color.gray).with(text: "Вы пока не совершили оплату")
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.register(PaymentHistoryCell.self, forCellReuseIdentifier: "Cell")
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.didLoad()
        setupViews()
        view.backgroundColor = .white
    }
    
    private func setupViews() {
        [titleLabel, noPaymentsLabel, tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGuidance.offset),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuidance.offsetDouble),
            
            noPaymentsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            noPaymentsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGuidance.offset),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func display(adapters: [PaymentHistoryCellAdapter]) {
        if !adapters.isEmpty {
            noPaymentsLabel.isHidden = false
        } else {
            noPaymentsLabel.isHidden = true
        }
        self.adapters = adapters
    }
    
    func setUserInteractionEnabled(_ enabled: Bool) {
        tableView.isUserInteractionEnabled = enabled
    }
}

extension PaymentHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PaymentHistoryCell else { return UITableViewCell() }
        cell.configure(adapter: adapters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectPayment(at: indexPath.row)
    }
    
}
