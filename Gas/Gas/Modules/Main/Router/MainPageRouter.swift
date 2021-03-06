//
//  MainPageRouter.swift
//  Gas
//
//  Created by Strong on 5/21/21.
//

import UIKit

class MainPageRouter: MainPageRouterInput {
    
    var viewController: UIViewController?
    
    func showShareActivity(for url: URL) {
        let activity = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil)
        viewController?.present(activity, animated: true, completion: nil)
    }
    
    func routeToReceipt(paymentId: Int, htmlCode: String) {
        let view = WebViewController()
        view.setTitle("Квитанция")
        view.setId(id: paymentId)
        view.setHtmlCode(htmlCode: htmlCode)
        view.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
