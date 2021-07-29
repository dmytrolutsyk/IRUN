//
//  RunningViewController.swift
//  IRUN
//
//  Created by VIDAL Léo on 29/07/2021.
//

import UIKit

class RunningViewController: UIViewController {
    
    private var isRunning = false {
        didSet {
            print("did set")
            if isRunning { self.setImgToStop() }
            else { self.setImgToStart() }
        }
    }


    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var temperatureTitleLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityTitleLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var historiqueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImgToStart()
        // Do any additional setup after loading the view.
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
