//
//  Course.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 13/07/2021.
//

import Foundation
import MapKit

class Course {
    
    var _id: String
    var startDate: Date
    var endDate: Date
    var distance: NSNumber
    var floorAscended: NSNumber
    var floorDescended: NSNumber
    var step: NSNumber
    var coordinates: [CLLocationCoordinate2D]
    
    init(_id: String, distance: NSNumber, step: NSNumber, floorAscended: NSNumber, floorDescended: NSNumber, startDate: Date, endDate: Date, coordinates: [CLLocationCoordinate2D]) {
        self._id = _id
        self.distance = distance
        self.step = step
        self.floorAscended = floorAscended
        self.floorDescended = floorDescended
        self.startDate = startDate
        self.endDate = endDate
        self.coordinates = coordinates
    }
}
