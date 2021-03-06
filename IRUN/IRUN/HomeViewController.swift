//
//  HomeViewController.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 25/05/2021.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {
    
    //class DeviceVC: UIViewController {
    
    enum ViewState: Int {
        case disconnected
        case connected
        case ready
    }
    
    var device: BTDevice? {
        didSet {
            navigationItem.title = device?.name ?? "Device"
            device?.delegate = self
        }
    }
    
    class func newInstance(device: BTDevice) -> HomeViewController {
        let homeViewController = HomeViewController()
        homeViewController.device = device
        return homeViewController
    }
    
    
    var text: String {
        get {
            return text
        }
        set {
            text = newValue
            //"do treatement"
        }
        
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var tempValue: UILabel!
    @IBOutlet weak var humValue: UILabel!
    @IBOutlet weak var pulseValue: UILabel!
    
    var viewState: ViewState = .disconnected {
        didSet {
            switch viewState {
            case .disconnected:
                statusLabel.text = "Deconnect√©"
               
                disconnectButton.isEnabled = false
                tempValue.isHidden = true
                humValue.isHidden = true
                pulseValue.isHidden = true
            case .connected:
                statusLabel.text = "Detection ..."
           
                disconnectButton.isEnabled = true
                tempValue.isHidden = true
                humValue.isHidden = true
                pulseValue.isHidden = true
                tempValue.text = device?.tmp ?? "reading..."
                humValue.text = device?.hum ?? "reading..."
                pulseValue.text = device?.pulse ?? "reading..."
            case .ready:
                statusLabel.text = "Connect√©"
                disconnectButton.isEnabled = true
                tempValue.isHidden = false
                humValue.isHidden = false
                pulseValue.isHidden = false
                
            }
        }
    }
    
    deinit {
        device?.disconnect()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Appareil connect√©"
        let _ = RunningService.shared.startCourse()
        viewState = .disconnected
    }

    @IBAction func disconnectAction(_ sender: Any) {
        guard let device = self.device else {return}
        RunningService.shared.setDevice(device: device)
        let home = RunningViewController()
        self.navigationController?.pushViewController(home, animated: true)
        /*
        device?.disconnect()
        goBack()*/
    }
}

extension HomeViewController: BTDeviceDelegate {
    func deviceSerialChanged(value: String) {
        serialLabel.text = value
    }
    
    func deviceDataTMPChanged(value: String) {
        tempValue.text = value
    }
    
    func deviceDataPULSEChanged(value: String) {
        pulseValue.text = value
    }
    
    func deviceDataHUMChanged(value: String) {
        humValue.text = value
    }
    
    func deviceConnected() {
        viewState = .connected
    }
    
    func deviceDisconnected() {
        viewState = .disconnected
    }
    
    func deviceReady() {
        viewState = .ready
    }
    
    func goBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
