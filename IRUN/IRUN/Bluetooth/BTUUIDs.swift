//
//  BTUUIDs.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 25/05/2021.
//

import Foundation
import CoreBluetooth


struct BTUUIDs {
    static let blinkOn = CBUUID(string: "e94f85c8-7f57-4dbd-b8d3-2b56e107ed60")
    static let blinkSpeed = CBUUID(string: "a8985fda-51aa-4f19-a777-71cf52abba1e")
    static let blinkService = CBUUID(string: "9a8ca9ef-e43f-4157-9fee-c37a3d7dc12d")
    static let espData = CBUUID(string: "df342b03-53f9-43b4-acb6-62a63ca0615a")

    
    static let infoService = CBUUID(string: "180a")
    static let infoManufacturer = CBUUID(string: "2a29")
    static let infoName = CBUUID(string: "2a24")
    static let infoSerial = CBUUID(string: "2a25")
}
