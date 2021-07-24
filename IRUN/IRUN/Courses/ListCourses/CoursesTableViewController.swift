//
//  CoursesTableViewController.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 13/07/2021.
//

import UIKit

class CoursesTableViewController: UITableViewController {
    
    @IBOutlet var tableV: UITableView!
    enum Identifier: String {
          case courses
         }
    var courses = [Course]()
    let courseService: CourseService = CourseService()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCoursesOfUser()
        let cellNib = UINib(nibName: "CourseTableViewCell", bundle: nil)
        self.tableV.register(cellNib, forCellReuseIdentifier: Identifier.courses.rawValue)
        self.tableV.delegate = self
        self.tableV.dataSource = self

    }
    
    private func getCoursesOfUser() {
        self.courseService.getCourses { courses in
            print("success get courses count : \(courses.count)")
            self.courses = courses
            self.tableV.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.courses.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.courses.rawValue, for: indexPath) as! CourseTableViewCell
        let course = self.courses[indexPath.row]
        cell.startDateLabel.text = course.startDate.description
        cell.timeLabel.text = course.duration.description
        return cell
    }
    
    
}

