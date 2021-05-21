//
//  PaymentHistoryRouter.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

enum PaymentListFilterType {
    case all
    case period(from: Date?, to: Date?)
    
    var payload: [String: Any]? {
        switch self {
        case .all:
            return [:]
        case .period(let from, let to):
            var params: [String: Any] = [:]
            if let fromDate = from?.toString(format: .formatted_ISO8601) {
                params["dateFrom"] = fromDate
            }
            if let toDate = to?.toString(format: .formatted_ISO8601) {
                params["dateTo"] = toDate
            }
            return params
        }
    }
}

class PaymentHistoryRouter: PaymentHistoryRouterInput {
    
    var viewController: UIViewController?
    
    func showFiltrationModule(filterType: PaymentListFilterType, submitHandler: @escaping ((PaymentListFilterType) -> Void)) {
        let viewController = PaymentListFilterViewController()
        viewController.configure(type: filterType)
        viewController.didTapSubmitHandler = submitHandler
        self.viewController?.navigationController?.present(viewController, animated: true)
    }
    
    func showShareActivity(for url: URL) {
        let activity = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil)
        viewController?.present(activity, animated: true, completion: nil)
    }
    
}
