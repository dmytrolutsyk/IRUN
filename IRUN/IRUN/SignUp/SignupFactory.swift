
import Foundation

class SignupFactory: CustomStringConvertible {
     
   /*
    
    */
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
        
    var description: String {
        return "{ Mail: \(self.email ), Password: \(self.password) }"
    }
    
    
    static func userFrom(dictionary: [String: Any]) -> User? {
           guard let email = dictionary["email"] as? String,
                 let password = dictionary["password"] as? String
        else {
                   return nil
           }
        let user = User(username: email, password: password)
           return user
       }
       
       static func dictionaryFrom(user: User) -> [String: Any] {
           return [
            "username": user.email,
            "password": user.password,
           ]
       }
    
}

