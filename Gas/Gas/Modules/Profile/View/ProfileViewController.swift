//
//  ProfileViewController.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

protocol SettingsCellAdapter {
    var localizedDescription: String { get }
    static var sectionTitle: String { get }
}

enum ProfilePersonalItem: CaseIterable, SettingsCellAdapter {
    case phoneNumber
    case email
    case personalAccount
    
    var localizedDescription: String {
        switch self {
        case .phoneNumber:
            return "Номер телефона"
        case .email:
            return "Эл. почта"
        case .personalAccount:
            return "Лицевой счет"
        }
    }
    
    static var sectionTitle: String {
        return "Личные данные"
    }
}

enum ProfileManagementItem: CaseIterable, SettingsCellAdapter {
    case changePassword
    case device
    case help
    case callSpecialist
    
    var localizedDescription: String {
        switch self {
        case .changePassword:
            return "Сменить пароль"
        case .device:
            return "Оборудование"
        case .help:
            return "Помощь"
        case .callSpecialist:
            return "Вызов специалиста"
        }
    }
    
    static var sectionTitle: String {
        return "Управление"
    }
}


class ProfileViewController: BaseViewController {
    
    var content: [[SettingsCellAdapter]] = [
        ProfilePersonalItem.allCases,
        ProfileManagementItem.allCases
    ]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Профиль"
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SettingsHeaderView()
        if (content[section][0]) as? ProfilePersonalItem != nil {
            view.setText(ProfilePersonalItem.sectionTitle)
        } else if (content[section][0]) as? ProfileManagementItem != nil {
            view.setText(ProfileManagementItem.sectionTitle)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        cell.configure(text: content[indexPath.section][indexPath.row].localizedDescription)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let action = content[indexPath.section][indexPath.row] as? ProfilePersonalItem {
            switch action {
            case .email:
                let view = AddEmailAssembly().assembleForChangeEmail(self)
                view.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(view, animated: true)
            case .personalAccount:
                break
            case .phoneNumber:
                let view = AddPhoneAssembly().assembleForChangeNumber(self)
                view.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(view, animated: true)
            }
        } else if let action = content[indexPath.section][indexPath.row] as? ProfileManagementItem {
            switch action {
            case .changePassword:
                let view = PasswordAssembly().assemble(mode: .change) { (input) -> PasswordModuleOutput? in
                    return self
                }
                view.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(view, animated: true)
            case .help:
                let view = HelpViewController()
                view.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(view, animated: true)
            default:
                break
            }
        }
        
    }
}

extension ProfileViewController: AddEmailModuleOutput, EmailVerificationModuleOutput, AddPhoneModuleOutput, SmsVerificationModuleOutput, PasswordModuleOutput {
    
    func didAdd(email: String) {
        let view = SmsVerificationAssembly().assembleChangeEmail(self, email: email)
        view.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(view, animated: true)
    }
    
    func didSucceedEmailVerification(email: String) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func didFailEmailVerification() {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func didFinish(with phoneNumber: String) {
        let view = SmsVerificationAssembly().assembleChangePhone(self, phoneNumber: "+\(phoneNumber)")
        view.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(view, animated: true)
    }
    
    func didSucceed(phoneNumber: String) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func didFail() {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func didSucceedPasswordSet() {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func didFailPasswordSet() {
        navigationController?.popToViewController(self, animated: true)
    }
    
}
