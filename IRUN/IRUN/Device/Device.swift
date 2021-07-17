//
//  Device.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 05/07/2021.
//

import Foundation

class Device: CustomStringConvertible {
    var id: Int?
    var title: String
    var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var description: String {
        return "{\(self.id ?? 0) \(self.title) \(self.subtitle)}"
    }
}
