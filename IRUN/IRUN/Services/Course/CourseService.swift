//
//  CourseService.swift
//  IRUN
//
//  Created by VIDAL Léo on 24/07/2021.
//

import Foundation

class CourseService {
    
    func getCourses(completion: @escaping ([Course]) -> Void) -> Void {
        guard let getCourseURL = URL(string: "https://irun-esgi.herokuapp.com/user/courses"),
              let token = SessionData.getToken() else {
                 return
        }
        var request = URLRequest(url: getCourseURL)
        request.httpMethod = "GET"
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, res, err) in
            guard let responseData = data,
                  let json = try? JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] else {
                print("error call getCourses")
                DispatchQueue.main.sync {
                    completion([])
                }
                return
            }
            
            let listOfCourses = CourseFactory.listOfCourseFrom(dict: json)
            DispatchQueue.main.sync {
                completion(listOfCourses)
            }
        })
        task.resume()

    }
    
    static func pushCourse(course: Course, completion: @escaping (Bool) -> Void) -> Void {
        guard let pushCourseURL = URL(string: "https://irun-esgi.herokuapp.com/user/course"),
              let token = SessionData.getToken() else {
                 return
        }
        var request = URLRequest(url: pushCourseURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: CourseFactory.dictionnaryFrom(course: course), options: .fragmentsAllowed)
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, res, err) in
            if let httpRes = res as? HTTPURLResponse {
                completion(httpRes.statusCode == 201)
                return
            }
            completion(false)
        })
        task.resume()
    }
}
