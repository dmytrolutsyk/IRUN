//
//  CourseFactory.swift
//  IRUN
//
//  Created by VIDAL Léo on 24/07/2021.
//

import Foundation
import MapKit

class CourseFactory {
    
    static func dictionnaryFrom(course: Course) -> [String:Any] {
        var listCoordinate = [Any]()
        for coord in course.coordinates {
            var dictCoord = [String:Any]()
            dictCoord.updateValue(coord.latitude, forKey: "latitude")
            dictCoord.updateValue(coord.longitude, forKey: "longitude")
            listCoordinate.append(dictCoord)
        }
        return [
            "runTime" : course.duration,
            "GPSCoordinate": listCoordinate,
            "runDistance": 25
        ]
    }
    
    static func listOfCourseFrom(dict: [String:Any]) -> [Course] {
        var listOfCourse = [Course]()
        guard let courses = dict["courses"] as? [Any] else {
            return listOfCourse
        }
        for course in courses {
            guard let dictCourse = course as? [String:Any],
                  let courseObject = courseFrom(dict: dictCourse) else { continue }
            listOfCourse.append(courseObject)
        }
        return listOfCourse
    }
    
    static func courseFrom(dict: [String:Any]) -> Course? {
        guard let runTime = dict["runTime"] as? Double,
              let startDateString = dict["startDate"] as? String,
              let endDateString = dict["endDate"] as? String,
              let startDate = dateFrom(string: startDateString),
              let endDate = dateFrom(string: endDateString),
              let listOfCoordinate = dict["GPSCoordinate"] as? [Any],
              let id = dict["_id"] as? String else { return nil }
        var GPSCoordinates = [CLLocationCoordinate2D]()

        for coord in listOfCoordinate {
            guard let dictCoord = coord as? NSDictionary,
                  let coordinate = coordinateFrom(dict: dictCoord) else { continue }
            GPSCoordinates.append(coordinate)
        }
        return Course(_id: id, duration: runTime, startDate: startDate, endDate: endDate, coordinates: GPSCoordinates)
    }
    
    static func coordinateFrom(dict: NSDictionary) -> CLLocationCoordinate2D? {
        guard let latitude = dict["latitude"] as? Double,
        let longitude = dict["longitude"] as? Double else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func dateFrom(string: String) -> Date? {
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        return dateFormatter.date(from: string)
    }
}
