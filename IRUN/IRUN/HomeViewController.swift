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
    
    var viewState: ViewState = .disconnected {
        didSet {
            switch viewState {
            case .disconnected:
                statusLabel.text = "Disconnected"
               
                disconnectButton.isEnabled = false
                serialLabel.isHidden = true
            case .connected:
                statusLabel.text = "Probing..."
           
                disconnectButton.isEnabled = true
                serialLabel.isHidden = true
            case .ready:
                statusLabel.text = "Ready"
                disconnectButton.isEnabled = true
                serialLabel.isHidden = false
                serialLabel.text = device?.serial ?? "reading..."
            }
        }
    }
    
    deinit {
        device?.disconnect()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Appareil connecté"
        
        viewState = .disconnected
    }

    @IBAction func disconnectAction(_ sender: Any) {
        device?.disconnect()
        goBack()
    }
}

extension HomeViewController: BTDeviceDelegate {
    func deviceSerialChanged(value: String) {
        serialLabel.text = value
    }
    
    func deviceDataChanged(value: String) {
        serialLabel.text = value
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
