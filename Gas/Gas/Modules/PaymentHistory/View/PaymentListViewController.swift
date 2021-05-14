//
//  PaymentListViewController.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

class PaymentListViewController: BaseViewController, PaymentHistoryViewInput {
    
    var output: PaymentHistoryViewOutput?
    private let filterButton = PaymentFilterButton()
    
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
    
    private let noPaymentsLabel = UILabel().with(font: .systemFont(ofSize: 16)).with(textColor: Color.gray).with(text: "Вы пока не совершили оплату")
    
    var adapters: [PaymentHistoryCellAdapter] = [] {
        didSet {
            updateVisibilityOfViews()
            if !adapters.isEmpty {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNavigationBarStyle()
        title = "История оплаты"
        
        output?.didLoad()
        setupViews()
    }
    
    func display(adapters: [PaymentHistoryCellAdapter]) {
        self.adapters = adapters
    }
    
    private func setupViews() {
        filterButton.tapHandler = {
//            self.output?.didTapFilter()
//            print("filter tapped")
        }
        [filterButton, noPaymentsLabel, tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            noPaymentsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noPaymentsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setUserInteractionEnabled(_ enabled: Bool) {}
    
    private func updateVisibilityOfViews() {
        if adapters.isEmpty {
            noPaymentsLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noPaymentsLabel.isHidden = true
            tableView.isHidden = false
        }
    }
}

extension PaymentListViewController: UITableViewDataSource, UITableViewDelegate {
    
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
