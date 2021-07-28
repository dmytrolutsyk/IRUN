//
//  DevicesTableViewController.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 05/07/2021.
//
import UIKit
import CoreBluetooth


class ListNearbyDevicesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyListLabel: UILabel!
    enum Identifier: String {
          case devices
         }
    
    private var manager = BTManager()
    
    var devices: [BTDevice] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
            self.handleEmptyList()
        }
    }
    
    @IBOutlet var scanLabel: UILabel!
    //@IBOutlet var scanLabel: UILabel!
    
    private func handleEmptyList() {
        if self.devices.isEmpty {
            self.tableView.isHidden = true
            self.emptyListLabel.isHidden = false
        } else {
            self.tableView.isHidden = false
            self.emptyListLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Appareils disponibles"
        self.handleEmptyList()
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
    

    
}

extension ListNearbyDevicesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.devices.rawValue, for: indexPath) as! CellTableViewCell
        let device = devices[indexPath.row]
        cell.textLabel?.text = device.name
        cell.detailTextLabel?.text = device.detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        device.connect()
        let vc = HomeViewController.newInstance(device: device)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ListNearbyDevicesViewController: BTManagerDelegate {
    func didChangeState(state: CBManagerState) {
        print("did change state ")
        devices = manager.devices
        updateStatusLabel()
        print("count devices : \(devices.count)")

    }
    
    func didDiscover(device: BTDevice) {
        print("did discover bt")
        devices = manager.devices
        print("count devices : \(devices.count)")
    }
    
    func didEnableScan(on: Bool) {
        updateStatusLabel()
    }
    
    
}
