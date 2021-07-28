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
    var duration: Double
    var coordinates: [CLLocationCoordinate2D]
    var listOfTemperature: [Double]
    var listOfHumidity: [Double]
    

    
    init(_id: String, duration: Double, startDate: Date, endDate: Date, coordinates: [CLLocationCoordinate2D], listHumidity: [Double], listTemperature: [Double]) {
        self._id = _id
        self.coordinates = coordinates
        self.duration = duration
        self.startDate = startDate
        self.endDate = endDate
        self.listOfHumidity = listHumidity
        self.listOfTemperature = listTemperature
    }
}
