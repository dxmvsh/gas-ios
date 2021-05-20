//
//  HelpViewController.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

enum HelpItem: CaseIterable {
    case howToUse
    case howToPay
    case errorIsComingUp
    case whereToGetIndicators
    case cantScan
    
    var localizedDescription: String {
        switch self {
        case .howToUse:
            return "Как пользоваться"
        case .howToPay:
            return "Как оплатить за газ"
        case .errorIsComingUp:
            return "Выдает ошибку"
        case .whereToGetIndicators:
            return "О компании"
        case .cantScan:
            return "Не сканирует счетчик"
        }
    }
    
    var text: String {
        switch self {
        case .errorIsComingUp, .howToUse, .howToPay:
            return """
            Приложнение не работает или выдает ошибку.
            Для начало проверьте подключение вашего
            устройства к интернету. Если ваш телефон подключен к сети попробуйте прочистить кэш на устройстве и переустановить KazTransgas из Play Market.
            Если рекомендации не помогли, позвоните
            в нашу службу поддержки и наши сотрудники помогут вам.
            """
        case .whereToGetIndicators:
            return """
            Чтобы измерить показатели вашего газа проверьте местоположение вашего счетчика.
            Он может находиться в подъезде а так же внутри вашей квартиры. После того как нашли, откройте сканнер который находится на нижней панеле вашего экрана и направьте в сторону счетчика. Наше приложение автоматически просканирует и высчитает вашу стоимость газа
            """
        case .cantScan:
            return """
            Попробуйте прочистить кэш на устройстве и переустановить KazTransgas из Play Market.
            Если рекомендации не помогли, позвоните
            в нашу службу поддержки и наши сотрудники помогут вам.
            """
        }
    }
}

class HelpViewController: BaseViewController {
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
        view.addSubview(tableView)
        setupDefaultNavigationBarStyle()
        setupBackButton()
        navigationItem.title = "Помощь"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HelpViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HelpItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        cell.configure(text: HelpItem.allCases[indexPath.row].localizedDescription)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = TextViewController(title: HelpItem.allCases[indexPath.row].localizedDescription, text: HelpItem.allCases[indexPath.row].text)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
