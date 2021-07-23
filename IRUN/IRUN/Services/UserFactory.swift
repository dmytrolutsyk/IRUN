//
//  UserFactory.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 12/07/2021.
//

import Foundation

class UserFactory {
     
    
    static func userFrom(user: [String: Any]) -> User? {
        guard    let email = user["email"] as? String,
                 let password = user["password"] as? String,
                 let username = user["username"] as? String,
                 let type = user["type"] as? String,
                 let phone = user["phone"] as? String,
                 let city = user["city"] as? String
                 
           else {
                   return nil
           }
        let user = User(email: email, password: password, type: type, username: username, phone: phone, city:city)
           return user
       }
    
    static func dictionaryFrom(user: User) -> [String: Any] {
        return [
            "username": user.username ?? "defaultusername",
            "password": user.password ?? "defaultpassword",
            "email": user.email ?? "defaultName",
            "phone": user.phone ?? "defaultphone",
            "city": user.city ?? "defaultcity",
            "usertype": user.type ?? "defaulttype"
        ]
    }
    
    static func responseLoginFrom(dictionary: [String: Any]) -> User? {
           guard let username = dictionary["username"] as? String,
                 let password = dictionary["password"] as? String
        else {
                   return nil
           }
        let user = User(username: username, password: password)
           return user
       }
    
    static func dictionaryLoginFrom(user: User) -> [String: Any] {
        return [
         "username": user.username,
         "password": user.password,
        ]
    }
}
