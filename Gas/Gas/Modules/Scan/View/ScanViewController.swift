//
//  ScanViewController.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import Foundation
import BlinkInput

class ScanViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = MBIFieldByFieldOverlaySettings(scanElements: [.init(identifier: "", parser: MBIParser())])
        let fieldByFieldOverlayViewController : MBIFieldByFieldOverlayViewController = MBIFieldByFieldOverlayViewController(settings: settings, delegate: self)

        /** Create recognizer view controller with wanted overlay view controller */
        let recognizerRunneViewController : UIViewController = MBIViewControllerFactory.recognizerRunnerViewController(withOverlayViewController: fieldByFieldOverlayViewController) ?? UIViewController()
        present(recognizerRunneViewController, animated: true, completion: nil)
    }
    
}

extension ScanViewController: MBIFieldByFieldOverlayViewControllerDelegate {
    
    func field(byFieldOverlayViewControllerWillClose fieldByFieldOverlayViewController: MBIFieldByFieldOverlayViewController) {
        
    }
    
    func field(_ fieldByFieldOverlayViewController: MBIFieldByFieldOverlayViewController, didFinishScanningWith scanElements: [MBIScanElement]) {
        
    }
    
    
}
