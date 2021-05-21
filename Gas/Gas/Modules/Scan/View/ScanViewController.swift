//
//  ScanViewController.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import Foundation
import Anyline

class ScanViewController: BaseViewController {

    var meterScanViewPlugin : ALMeterScanViewPlugin!;
    var meterScanPlugin : ALMeterScanPlugin!;
    var scanView : ALScanView!;
    
    let kELMeterScanLicenseKey = kLicenseKey;
    
    var didFinishScanningClosure: ((NSString) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = UIColor.black
    
        do {
            self.meterScanPlugin = try ALMeterScanPlugin.init(pluginID:"ENERGY", licenseKey: kELMeterScanLicenseKey, delegate: self);
            try self.meterScanPlugin.setScanMode(ALScanMode.autoAnalogDigitalMeter);
            
            self.meterScanViewPlugin = ALMeterScanViewPlugin.init(scanPlugin: self.meterScanPlugin);
            self.scanView = ALScanView.init(frame: self.view.bounds, scanViewPlugin: self.meterScanViewPlugin);
        } catch {
            print("Setup error: \(error.localizedDescription).")
        }
      
        self.view.addSubview(self.scanView);
        self.scanView.startCamera();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        do {
            try self.meterScanViewPlugin.stop();
        } catch {
            print("Stop error: \(error.localizedDescription).")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        do {
            try self.meterScanViewPlugin.start();
        } catch {
            print("Start error: \(error.localizedDescription).")
        }
    }
    
}

extension ScanViewController: ALMeterScanPluginDelegate {
    func anylineMeterScanPlugin(_ anylineMeterScanPlugin: ALMeterScanPlugin, didFind scanResult: ALMeterResult) {
        didFinishScanningClosure?(scanResult.result)
        navigationController?.popViewController(animated: true)
    }
}
