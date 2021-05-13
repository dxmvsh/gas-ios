//
//  AccountListViewController.swift
//  Gas
//
//  Created by Strong on 5/12/21.
//

import UIKit

class AccountListViewController: UIViewController, AccountListViewInput {
    
    var output: AccountListViewOutput?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AccountListCell.self, forCellReuseIdentifier: "cell")
        tableView.register(AccountListHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.separatorInset = .init(top: .zero, left: LayoutGuidance.offset, bottom: .zero, right: LayoutGuidance.offset)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 32
        return tableView
    }()
    
    private var accounts: [AccountInformationDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func display(models: [AccountInformationDataModel]) {
        self.accounts = models
        tableView.reloadData()
    }
    
}

extension AccountListViewController: UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AccountListCell else {
            return UITableViewCell()
        }
        cell.configure(model: accounts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? AccountListHeaderView else { return nil }
        return header
    }
    
}
