//
//  PaymentOrderT.swift
//  Gas
//
//  Created by Strong on 5/14/21.
//

import UIKit

class PaymentOrderRouter: PaymentOrderRouterInput {
    var viewController: UIViewController?
    
    func showResultViewController(isSuccess: Bool, title: String, subtitle: String, image: UIImage, completion: @escaping (() -> Void)) {
        let viewController = ResultViewController()
        viewController.setSuccessState()
        viewController.modalPresentationStyle = .fullScreen
        self.viewController?.navigationController?.present(viewController, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewController.dismiss(animated: true) {
                    completion()
                }
            }
        })
    }
}
