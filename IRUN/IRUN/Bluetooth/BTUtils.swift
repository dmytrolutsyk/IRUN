//
//  BTUtils.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 25/05/2021.
//

import Foundation
import CoreBluetooth


extension CBManagerState: CustomStringConvertible {
    
    public var description: String {
        switch self {
            case .unknown: return "unknown"
            case .resetting: return "resetting"
            case .unsupported: return "unsupported"
            case .unauthorized: return "unauthorized"
            case .poweredOff: return "poweredOff"
            case .poweredOn: return "poweredOn"
        @unknown default:
            fatalError()
        }
    }
}


extension Data {
    func parseBool() -> Bool? {
        guard count == 1 else { return nil }
        
        return self[0] != 0 ? true : false
    }
    
    func parseInt() -> UInt8? {
        guard count == 1 else { return nil }
        return self[0]
    }
}
