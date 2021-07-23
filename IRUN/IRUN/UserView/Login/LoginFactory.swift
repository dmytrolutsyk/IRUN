

import Foundation

class LoginFactory: CustomStringConvertible {
     
        
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
        
    var description: String {
        return "{ Username: \(self.username ), Password: \(self.password) }"
    }
    
    

       

    
}
