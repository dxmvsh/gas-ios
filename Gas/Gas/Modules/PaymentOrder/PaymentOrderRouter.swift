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
        if isSuccess {
            viewController.setSuccessState(title: title, subtitle: subtitle, image: image)
        } else {
            viewController.setFailureState(title: title, subtitle: subtitle, image: image)
        }
        viewController.modalPresentationStyle = .fullScreen
        self.viewController?.navigationController?.present(viewController, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                viewController.dismiss(animated: true) {
                    completion()
                }
            }
        })
    }
    
    func routeToScan(completion: ((NSString) -> Void)?) {
        let viewController = ScanViewController()
        viewController.didFinishScanningClosure = completion
        viewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
