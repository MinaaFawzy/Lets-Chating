import Foundation
import FirebaseDatabase

struct User {
    let ref: DatabaseReference?
    var id: String
    var userName: String
    var email: String
    var phoneNum: String
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: "@", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
    var profilePicFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
        
    init (){
        ref = nil
        id = ""
        userName = ""
        email = ""
        phoneNum = ""
    }
    init(id: String, userName: String, email: String,phoneNum: String){
        self.ref = nil
        self.id = id
        self.userName = userName
        self.email = email
        self.phoneNum = phoneNum
    }
    
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String:AnyObject],
            let id = value["id"] as? String,
            let userName = value["userName"] as? String,
            let email = value["email"] as? String,
            let phoneNum = value["phoneNum"] as? String else {return nil}
        
        self.ref = snapshot.ref
        self.id = id
        self.userName = userName
        self.email = email
        self.phoneNum = phoneNum
    }
    
    func toAnyObject() -> Any {
        return [
            "id" : id,
            "userName" : userName,
            "email" : email,
            "phoneNum" : phoneNum
        ]
    }
    static func safeEmail(email: String)-> String {
        var safeEmail = email.replacingOccurrences(of: "@", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
}
