//
//  BTDevice.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 25/05/2021.
//

import Foundation
import CoreBluetooth


protocol BTDeviceDelegate: AnyObject {
    func deviceConnected()
    func deviceReady()
    func deviceSerialChanged(value: String)
    func deviceDataTMPChanged(value: String)
    func deviceDataPULSEChanged(value: String)
    func deviceDataHUMChanged(value: String)
    func deviceDisconnected()

}

class BTDevice: NSObject {
    private let peripheral: CBPeripheral
    private let manager: CBCentralManager
    private var espTMPChar: CBCharacteristic?
    private var espTMP: String = "nil"
    private var espPULSEChar: CBCharacteristic?
    private var espPULSE: String = "nil"
    private var espHUMChar: CBCharacteristic?
    private var espHUM: String = "nil"
    
    weak var delegate: BTDeviceDelegate?

    var name: String {
        return peripheral.name ?? "Unknown device"
    }
    var detail: String {
        return peripheral.identifier.description
    }
    private(set) var serial: String?
    private(set) var tmp: String?
    private(set) var pulse: String?
    private(set) var hum: String?
    
    init(peripheral: CBPeripheral, manager: CBCentralManager) {
        self.peripheral = peripheral
        self.manager = manager
        super.init()
        self.peripheral.delegate = self
    }
    
    func connect() {
        manager.connect(peripheral, options: nil)
    }
    
    func disconnect() {
        manager.cancelPeripheralConnection(peripheral)
    }
}

extension BTDevice {
    // these are called from BTManager, do not call directly
    
    func connectedCallback() {
        peripheral.discoverServices([BTUUIDs.EspService, BTUUIDs.infoService])
        delegate?.deviceConnected()
    }
    
    func disconnectedCallback() {
        delegate?.deviceDisconnected()
    }
    
    func errorCallback(error: Error?) {
        print("Device: error \(String(describing: error))")
    }
}


extension BTDevice: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Device: discovered services")
        peripheral.services?.forEach {
            print("  \($0)")
            if $0.uuid == BTUUIDs.infoService {
                peripheral.discoverCharacteristics([BTUUIDs.infoSerial], for: $0)
            } else if $0.uuid == BTUUIDs.espTMP {
                peripheral.discoverCharacteristics([BTUUIDs.espTMP], for: $0)
            } else if $0.uuid == BTUUIDs.espPULSE {
                peripheral.discoverCharacteristics([BTUUIDs.espPULSE], for: $0)
            } else if $0.uuid == BTUUIDs.espHUM {
                peripheral.discoverCharacteristics([BTUUIDs.espHUM], for: $0)
            } else {
                peripheral.discoverCharacteristics(nil, for: $0)
            }
        }
        print()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("Device: discovered characteristics")
        service.characteristics?.forEach {
            print("   \($0)")
            
             if $0.uuid == BTUUIDs.infoSerial {
                peripheral.readValue(for: $0)
                peripheral.setNotifyValue(true, for: $0)
            } else if $0.uuid == BTUUIDs.espTMP {
                peripheral.readValue(for: $0)
                peripheral.setNotifyValue(true, for: $0)
            } else if $0.uuid == BTUUIDs.espPULSE {
                peripheral.readValue(for: $0)
                peripheral.setNotifyValue(true, for: $0)
            } else if $0.uuid == BTUUIDs.espHUM {
                peripheral.readValue(for: $0)
                peripheral.setNotifyValue(true, for: $0)
            }
            
        }
        print()
        
        delegate?.deviceReady()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Device: updated value for \(characteristic)")
        
        if characteristic.uuid == BTUUIDs.espTMP, let d = characteristic.value {
            tmp = String(data: d, encoding: .utf8)
            if let tmp = tmp {
                delegate?.deviceDataTMPChanged(value: tmp)
                print("ESP TEMP: \(tmp)")
            }
        }
        if characteristic.uuid == BTUUIDs.espPULSE, let d = characteristic.value {
            pulse = String(data: d, encoding: .utf8)
            if let pulse = pulse {
                delegate?.deviceDataPULSEChanged(value: pulse)
                print("ESP PULSE: \(pulse)")
            }
        }
        if characteristic.uuid == BTUUIDs.espHUM, let d = characteristic.value {
            hum = String(data: d, encoding: .utf8)
            if let hum = hum {
                delegate?.deviceDataHUMChanged(value: hum)
                print("ESP HUM: \(hum)")
            }
        }
        if characteristic.uuid == BTUUIDs.infoSerial, let d = characteristic.value {
            serial = String(data: d, encoding: .utf8)
            if let serial = serial {
                delegate?.deviceSerialChanged(value: serial)
            }
        }
    }
}

