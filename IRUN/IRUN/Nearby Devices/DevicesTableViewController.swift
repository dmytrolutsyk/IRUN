//
//  DevicesTableViewController.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 05/07/2021.
//
import UIKit
import CoreBluetooth


class DevicesTableViewController: UITableViewController {
    
    enum Identifier: String {
          case devices
         }
    
    private var manager = BTManager()
    
    var devices: [BTDevice] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    //@IBOutlet var scanLabel: UILabel!
    @IBOutlet var scanLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Appareils disponibles"
        
        /*toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: scanLabel),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        ]*/
        updateStatusLabel()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(touchEdit))
        let cellNib = UINib(nibName: "CellTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: Identifier.devices.rawValue)
        self.tableView.dataSource = self
        
        
        manager.delegate = self
    }
    @objc func touchEdit() {
        UIView.animate(withDuration: 0.33) {
            self.tableView.isEditing = !self.tableView.isEditing
        }
    }

    
    
    func updateStatusLabel() {
        scanLabel.text = "state: \(manager.state), scan: \(manager.scanning)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.devices.rawValue, for: indexPath) as! CellTableViewCell
        let device = devices[indexPath.row]
        cell.textLabel?.text = device.name
        cell.detailTextLabel?.text = device.detail
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        device.connect()
        let vc = HomeViewController.newInstance(device: device)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension DevicesTableViewController: BTManagerDelegate {
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
