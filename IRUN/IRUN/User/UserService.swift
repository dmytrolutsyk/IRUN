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
            guard let response = data,
                  let responseString = String(data: response, encoding: .utf8),
                  let dict = responseString.toJSON() as? [String:Any],
                  let token = dict["token"] as? String else {
                DispatchQueue.main.sync {
                    completion(false)
                }
                return
            }
            
            // Stock token in session
            SessionData.setToken(token: token)
            DispatchQueue.main.sync {
                completion(true)
            }
        })
        task.resume()
    }
    
    func login(user: User, completion: @escaping (Bool) -> Void) -> Void {
            //guard let loginURL = URL(string: "http://localhost:3000/signin") else {
            guard let loginURL = URL(string: "https://irun-esgi.herokuapp.com/user/signIn") else {
               return
           }
           var request = URLRequest(url: loginURL)
           request.httpMethod = "POST"
           request.httpBody = try? JSONSerialization.data(withJSONObject: UserFactory.dictionaryLoginFrom(user: user), options: .fragmentsAllowed)
           request.setValue("application/json", forHTTPHeaderField: "content-type")
           let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
            
            guard let response = data,
                  let responseString = String(data: response, encoding: .utf8),
                  let dict = responseString.toJSON() as? [String:Any],
                  let token = dict["token"] as? String else {
                DispatchQueue.main.sync {
                    completion(false)
                }
                return
            }
            
            // Stock token in session
            SessionData.setToken(token: token)
            DispatchQueue.main.sync {
                completion(true)
            }
            
           })
           task.resume()
       }
    
  
  
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
