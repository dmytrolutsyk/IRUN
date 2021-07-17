var JWT:String? = ""
var ERR:String? = ""
 
import Foundation


class LoginService {
    
    func login(user: User, completion: @escaping (Bool) -> Void) -> Void {
            guard let loginURL = URL(string: "http://localhost:3000/signin") else {
            //guard let loginURL = URL(string: "https://blabla.herokuapp.com/signin") else {
               return
           }
           var request = URLRequest(url: loginURL)
           request.httpMethod = "POST"
           request.httpBody = try? JSONSerialization.data(withJSONObject: LoginFactory.dictionaryFrom(user: user), options: .fragmentsAllowed)
           request.setValue("application/json", forHTTPHeaderField: "content-type")
           let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
               if let httpRes = res as? HTTPURLResponse {
                
                completion(httpRes.statusCode == 200)
               }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                      // print("data: \(dataString)")

                let dict = dataString.toJSON() as? [String:AnyObject]
                 JWT = (dict?["token"] as AnyObject? as? String) ?? "notoken"
                 ERR = (dict?["error"] as AnyObject? as? String) ?? "Login OK"
                               
                    completion(true)
            } else {

                completion(false)
            }
           })
        
           task.resume()
       }
    
    


}
 
struct Userdata: Decodable {
    let token: String?
    let error: String?

}
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
