//
//  NearbyDevicesViewController.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 25/05/2021.
//

import UIKit

import CoreBluetooth


class NearbyDevicesVC: UITableViewController {
    private var manager = BTManager()
    private var devices: [BTDevice] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    @IBOutlet var scanLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Appeils disponible:";
        
        updateStatusLabel()
        
        manager.delegate = self
    }
    
    func updateStatusLabel() {
        scanLabel.text = "state: \(manager.state), scan: \(manager.scanning)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell")!
        let device = devices[indexPath.row]
        cell.textLabel?.text = device.name
        cell.detailTextLabel?.text = device.detail
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "") as! HomeViewController
        vc.device = device
        device.connect()
        show(vc, sender: self)
    }
}

extension NearbyDevicesVC: BTManagerDelegate {
    func didChangeState(state: CBManagerState) {
        devices = manager.devices
        updateStatusLabel()
    }
    
    func didDiscover(device: BTDevice) {
        devices = manager.devices
    }
    
    func didEnableScan(on: Bool) {
        updateStatusLabel()
    }
    
    
}

