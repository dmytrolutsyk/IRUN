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
    
    var temp: Double?
    var humidity: Double?
    var pulse: Double?
    
    private var isRunning = false
        
    init() {
        self.course = Course(_id: "", duration: 0, startDate: Date(), endDate: Date(), coordinates: [], listHumidity: [], listTemperature: [], listPulse: [])
    }
    
    func startCourse() {
        print("start course")
        self.course = Course(_id: "", duration: 0, startDate: Date(), endDate: Date(), coordinates: [], listHumidity: [], listTemperature: [], listPulse: [])
        isRunning = true
        self.remplissageDataCourse()
    }
    
    private func remplissageDataCourse() {
        self.remplissageHumidityEveryMinute()
        self.remplissageTemperatureEveryMinute()
        self.remplissagePulseEveryMinute()
    }
    
    func publishLocation(coordinate: CLLocationCoordinate2D) {
        if isRunning {
            self.course.coordinates.append(coordinate)
        }
    }
    
    func updateLocation(coord: CLLocationCoordinate2D) {
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
    
    private func remplissagePulseEveryMinute() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) {timer in
            if self.isRunning {
                guard let pulse = self.pulse else {
                    print("no pulse available")
                    return
                }
                print("add pulse to course : \(pulse)")
                self.course.listOfPulse.append(pulse)
            } else {
                print("stop repeats remplissage pulse")
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
    
    func setDevice(device: BTDevice) {
        self.device = device
    }
    
    
}


extension RunningService: BTDeviceDelegate {
    
    func deviceDataTMPChanged(value: String) {
        guard let temperature = Double(value) else {
            print("error cast temp")
            return
        }
        self.temp = temperature
    }
    
    func deviceDataHUMChanged(value: String) {
        guard let humidity = Double(value) else {
            print("error cast humidity")
            return
        }
        self.humidity = humidity
    }
    
    func deviceDataPULSEChanged(value: String) {
        guard let pulse = Double(value) else {
            print("error casting pulse value")
            return
        }
        self.pulse = pulse
    }
    
    func deviceConnected() {
        
    }
    
    func deviceReady() {
        
    }
    
    func deviceSerialChanged(value: String) {
        
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
