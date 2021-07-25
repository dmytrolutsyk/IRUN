//
//  BTUUIDs.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 25/05/2021.
//

import Foundation
import CoreBluetooth


struct BTUUIDs {

    static let EspService = CBUUID(string: "4fafc201-1fb5-459e-8fcc-c5c9c331914b")
    static let espTMP = CBUUID(string: "beb5483e-36e1-4688-b7f5-ea07361b26a8")
    static let espPULSE = CBUUID(string: "a8985fda-51aa-4f19-a777-71cf52abba1e")
    static let espHUM = CBUUID(string: "e94f85c8-7f57-4dbd-b8d3-2b56e107ed60")

    
    static let infoService = CBUUID(string: "180a")
    static let infoManufacturer = CBUUID(string: "2a29")
    static let infoName = CBUUID(string: "2a24")
    static let infoSerial = CBUUID(string: "2a25")
}
