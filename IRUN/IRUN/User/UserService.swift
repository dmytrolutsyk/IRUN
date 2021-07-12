//
//  UserService.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 12/07/2021.
//

import Foundation

typealias UserCompletion = ([User]) -> Void


class UserService {
    
  
    
    func newUser(user: User, completion: @escaping (Bool) -> Void) -> Void {
        guard let usertURL = URL(string: "https://webhook.site/a382090f-c7b9-4522-988c-19a595fc9549") else {
            return
        }
        var request = URLRequest(url: usertURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: UserFactory.dictionaryFrom(user: user), options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
            if let httpRes = res as? HTTPURLResponse {
                print(httpRes.statusCode)
                completion(httpRes.statusCode == 201)
                return
            }
            print("Error \(err.debugDescription)")
            completion(false)
        })
        task.resume()
    }
    
  
  
    
}
