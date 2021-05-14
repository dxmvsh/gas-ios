//
//  SettingsViewController.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

enum SettingsNotificationItem {
    case pushNotifications(isOn: Bool)
    case biometry(isOn: Bool)
    
    var localizedDescription: String {
        switch self {
        case .pushNotifications:
            return "Push уведомления"
        case .biometry:
            return "Touch ID/Face ID"
        }
    }
    
    static var allCases: [SettingsNotificationItem] {
        return [.pushNotifications(isOn: true), .biometry(isOn: true)]
    }
    
    static var sectionTitle: String {
        return "Уведомления"
    }
}

enum SettingsOtherItem: CaseIterable {
    case language
    case publicOffer
    case security
    case about
    
    var localizedDescription: String {
        switch self {
        case .language:
            return "Язык приложения"
        case .publicOffer:
            return "Публичная оферта"
        case .security:
            return "Безопасность"
        case .about:
            return "О компании"
        }
    }
    
    static var sectionTitle: String {
        return "Другие"
    }
}

class SettingsViewController: BaseViewController {
    
    private var notificationItems: [SettingsNotificationItem] = SettingsNotificationItem.allCases
    private var otherItems: [SettingsOtherItem] = SettingsOtherItem.allCases
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        view.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        view.separatorInset = .init(top: .zero, left: LayoutGuidance.offset, bottom: .zero, right: LayoutGuidance.offset)
        view.backgroundColor = .white
        return view
    }()
    
    private let button = Button.makeSecondary(title: "Выйти с аккаунта")
    
    private let secureAuth = SecureAuthentication(dataProvider: AuthorizationService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Настройки"
        button.setTitleColor(Color.fail, for: .normal)
        view.backgroundColor = .white
        [tableView, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        button.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: LayoutGuidance.offsetDouble),
            button.heightAnchor.constraint(equalToConstant: ViewSize.buttonHeight),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutGuidance.offsetDouble)
        ])
    }
    
    
    var logoutHandler: (() -> Void)?
    
    @objc
    private func logOutTapped() {
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите выйти?", preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Выйти", style: .destructive) { action in
            self.secureAuth.flushToken()
            self.logoutHandler?()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
            alert.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(logOutAction)
        
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return notificationItems.count
        } else if section == 1 {
            return otherItems.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SettingsHeaderView()
        if section == 0 {
            view.setText(SettingsNotificationItem.sectionTitle)
        } else if section == 1 {
            view.setText(SettingsOtherItem.sectionTitle)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.configure(text: notificationItems[indexPath.row].localizedDescription, hasSwitch: true, isOn: true)
            cell.setDisabled()
        } else if indexPath.section == 1 {
            cell.configure(text: otherItems[indexPath.row].localizedDescription)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        let viewController = TextViewController(title: otherItems[indexPath.row].localizedDescription)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
