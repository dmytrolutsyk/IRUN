//
//  RunService.swift
//  IRUN
//
//  Created by VIDAL Léo on 28/07/2021.
//

import Foundation
import MapKit

class RunningService {
    
    static let shared = RunningService()
    
    var device: BTDevice? {
        didSet {
            device?.delegate = self
        }
    }
    
    
    private var course: Course
    
    private var temp: Double?
    private var humidity: Double?
    
    private var isRunning = false
        
    init() {
        self.course = Course(_id: "", duration: 0, startDate: Date(), endDate: Date(), coordinates: [], listHumidity: [], listTemperature: [])
    }
    
    func startCourse() {
        print("start course")
        self.course = Course(_id: "", duration: 0, startDate: Date(), endDate: Date(), coordinates: [], listHumidity: [], listTemperature: [])
        isRunning = true
        self.remplissageHumidityEveryMinute()
        self.remplissageTemperatureEveryMinute()
    }
    func addCoordinateToCourse(coord: CLLocationCoordinate2D) {
        if isRunning {
            self.course.coordinates.append(coord)
        }
    }
    
    func endCourse() -> Course {
        print("end course")
        isRunning = false
        self.course.endDate = Date()
        return self.course
    }
    
    private func remplissageHumidityEveryMinute() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) {timer in
            if self.isRunning {
                guard let humidity = self.temp else {
                    print("no humidity available")
                    return
                }
                print("add humidity to course : \(humidity)")
                self.course.listOfHumidity.append(humidity)
            } else {
                print("stop repeats remplissage humidity")
                timer.invalidate()
            }
        }
    }
    
    private func remplissageTemperatureEveryMinute() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) {timer in
            if self.isRunning {
                guard let temperature = self.temp else {
                    print("no temp available")
                    return
                }
                print("add temperature to course : \(temperature)")
                self.course.listOfTemperature.append(temperature)
            } else {
                print("stop repeats remplissage temperature")
                timer.invalidate()
            }
        }
    }
    
    
}


extension RunningService: BTDeviceDelegate {
    
    func deviceDataTMPChanged(value: String) {
        print("update temp")
        guard let temperature = Double(value) else {
            print("error cast temp")
            return
        }
        self.temp = temperature
        print("update temp: \(temperature)")
    }
    
    func deviceDataHUMChanged(value: String) {
        print("update humidity")
        guard let humidity = Double(value) else {
            print("error cast humidity")
            return
        }
        self.humidity = humidity
        print("update humidity: \(humidity)")
    }
    
    func deviceConnected() {
        
    }
    
    func deviceReady() {
        
    }
    
    func deviceSerialChanged(value: String) {
        
    }
    
    func deviceDataPULSEChanged(value: String) {
        
    }
    
    func deviceDisconnected() {
        // TODO handle disconnect esp
    }
    
    
}

extension Notification.Name {
    static var temperatureDataUpdate: Notification.Name {
        return .init(rawValue: "device.temperatureDataUpdate")
    }

    static var levelHumidityUpdate: Notification.Name {
        return .init(rawValue: "device.levelHumidityUpdate")
    }
}
