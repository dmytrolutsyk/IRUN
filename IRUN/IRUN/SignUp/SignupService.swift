import Foundation

class SignupService {
    
      func signup(user: User, completion: @escaping (Bool) -> Void) -> Void {
          // guard let signupURL = URL(string: "http://localhost:3000/signup") else {
        guard let signupURL = URL(string: "https://irun-esgi.herokuapp.com/user/signUp") else {
                 return
             }
            
             var request = URLRequest(url: signupURL)
             request.httpMethod = "POST"
             request.httpBody = try? JSONSerialization.data(withJSONObject: SignupFactory.dictionaryFrom(user: user), options: .fragmentsAllowed)
             request.setValue("application/json", forHTTPHeaderField: "content-type")
             let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
                 if let httpRes = res as? HTTPURLResponse {
                  
                  completion(httpRes.statusCode == 200)
                 }
              
              if let data = data, let dataString = String(data: data, encoding: .utf8) {
                let dict = dataString.toJSON() as? [String:AnyObject]
                ERR = (dict?["error"] as AnyObject? as? String) ?? "Signup OK"
                         print("data: \(dataString)")
                      completion(true)
              } else {

                  completion(false)
              }
              
             })
          
             task.resume()
         }


}


