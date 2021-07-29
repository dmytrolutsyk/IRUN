//
//  RunningViewController.swift
//  IRUN
//
//  Created by VIDAL Léo on 29/07/2021.
//

import UIKit
import MapKit

class RunningViewController: UIViewController, MKMapViewDelegate {
    
    private var isRunning = false {
        didSet {
            print("did set")
            if isRunning { self.setImgToStop() }
            else { self.setImgToStart() }
        }
    }
    
    var locationManager: CLLocationManager?

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var temperatureTitleLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityTitleLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var pulseLabel: UILabel!
    
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var historiqueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImgToStart()
        
        // Ask permission if not for localisation
        if CLLocationManager.locationServicesEnabled() {
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            self.locationManager = locationManager
        }
        
        // Do any additional setup after loading the view.
    }
    
    func getDataFromRunningService() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) {timer in
            guard let pulse = RunningService.shared.pulse,
                  let humidity = RunningService.shared.humidity,
                  let temp = RunningService.shared.temp else {
                return
            }
            self.pulseLabel.text = pulse.description
            self.humidityLabel.text = humidity.description
            self.temperatureLabel.text = temp.description
        }
    }
    
    @IBAction func goToHistorique(_ sender: Any) {
        let home = CoursesTableViewController()
        self.navigationController?.pushViewController(home, animated: true)
    }
    
    @IBAction func startStopAction(_ sender: Any) {
        self.startStopRunning()
    }
    
    private func setImgToStart() {
        self.startStopButton.setImage(UIImage(named: "start_img"), for: .normal)
    }
    
    private func setImgToStop() {
        self.startStopButton.setImage(UIImage(named: "stop_img"), for: .normal)

    }
    
    private func publishLocation(coordinate: CLLocationCoordinate2D) {
        print("publish location")
        RunningService.shared.updateLocation(coord: coordinate)
    }
    
    private func startStopRunning() {
        if isRunning {
            // Terminer la course
            let course = RunningService.shared.endCourse()
            print("course hum count : \(course.listOfHumidity.count)")
            print("course temp count : \(course.listOfTemperature.count)")
            print("course pulse count : \(course.listOfPulse.count)")
            CourseService.pushCourse(course: course, completion: { reussite in
                print("call network : \(reussite)")
            })

        } else {
            RunningService.shared.startCourse()
        }
        self.isRunning = !self.isRunning
    }

}

extension RunningViewController: CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let location = userLocation.location else {
            return
        }
        print("function update location : \(location.coordinate.latitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //self.locationManager?.stopUpdatingLocation() // Arrete la geoloc ---> 1 seul la position GPS
        guard let location = locations.last else {
            return
        }
        let coord = location.coordinate
        print("function update location : \(location.coordinate.latitude)")
        self.publishLocation(coordinate: coord)
        
    }
}
