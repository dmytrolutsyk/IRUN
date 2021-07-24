//
//  DetailCourseViewController.swift
//  IRUN
//
//  Created by VIDAL Léo on 20/07/2021.
//

import UIKit
import MapKit

class DetailCourseViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var course: Course!
    var listOfCoordinate: [CLLocationCoordinate2D] {
        return self.course.coordinates
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
//        self.mockData()
        self.drawCourse()
    }
    
    static func newInstance(course: Course) -> DetailCourseViewController {
        let detailCourse = DetailCourseViewController()
        detailCourse.course = course
        return detailCourse
    }
    
    private func mockData() {
        let course = Course(_id: "0", duration: 26, startDate: Date(), endDate: Date(), coordinates: [])
        course.coordinates.append(CLLocationCoordinate2D(latitude: 48.665033, longitude: 2.840410))
        course.coordinates.append(CLLocationCoordinate2D(latitude: 48.665007, longitude: 2.840899))
        course.coordinates.append(CLLocationCoordinate2D(latitude: 48.665297, longitude: 2.841232))
        course.coordinates.append(CLLocationCoordinate2D(latitude: 48.665778, longitude: 2.841284))
        course.coordinates.append(CLLocationCoordinate2D(latitude: 48.666301, longitude: 2.840769))
        course.coordinates.append(CLLocationCoordinate2D(latitude: 48.666353, longitude: 2.840146))
        course.coordinates.append(CLLocationCoordinate2D(latitude: 48.665033, longitude: 2.840410))
        self.course = course
    }
    
    private func drawCourse() {
        var isFirstLocation = true
        var previousLoaction = CLLocationCoordinate2D()
        
        for location in self.listOfCoordinate {
            if isFirstLocation {
                isFirstLocation = false
                previousLoaction = location
            } else {
                self.drawBetween2Coord(firstLocation: previousLoaction, secondLocation: location)
                previousLoaction = location
            }
        }
    }
    
    private func setMKPointOfStartAndEnd() {
        
    }
    
    private func drawBetween2Coord(firstLocation: CLLocationCoordinate2D, secondLocation: CLLocationCoordinate2D) {
        let firstMapItem = MKMapItem(placemark: MKPlacemark(coordinate: firstLocation))
        let secondMapItem = MKMapItem(placemark: MKPlacemark(coordinate: secondLocation))
        
        let request = MKDirections.Request()
        request.source = firstMapItem
        request.destination = secondMapItem
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            guard let mapRoute = response?.routes.first else {
                return
            }
            self.updateView(mapRoute: mapRoute)
        }

    }
    
    private func updateView(mapRoute: MKRoute) {
        let padding: CGFloat = 8
        mapView.addOverlay(mapRoute.polyline)
        mapView.setVisibleMapRect(
          mapView.visibleMapRect.union(
            mapRoute.polyline.boundingMapRect
          ),
          edgePadding: UIEdgeInsets(
            top: 0,
            left: padding,
            bottom: padding,
            right: padding
          ),
          animated: true
        )
    }



}

extension DetailCourseViewController: MKMapViewDelegate {
  func mapView(
    _ mapView: MKMapView,
    rendererFor overlay: MKOverlay
  ) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(overlay: overlay)

    renderer.strokeColor = .systemBlue
    renderer.lineWidth = 3
    
    return renderer
  }
}
