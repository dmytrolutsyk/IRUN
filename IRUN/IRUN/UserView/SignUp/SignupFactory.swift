
import Foundation

class SignupFactory: CustomStringConvertible {
     
   /*
    
    */
    
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
        
    var description: String {
        return "{ Username: \(self.username ), Password: \(self.password) }"
    }
    
    
    static func userFrom(dictionary: [String: Any]) -> User? {
           guard let username = dictionary["username"] as? String,
                 let password = dictionary["password"] as? String
        else {
                   return nil
           }
        let user = User(username: username, password: password)
           return user
       }
       
       static func dictionaryFrom(user: User) -> [String: Any] {
           return [
            "username": user.username,
            "password": user.password,
           ]
       }
    
}

