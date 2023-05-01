import Foundation
import FirebaseDatabase

struct User {
    let ref: DatabaseReference?
    let id: String
    let userName: String
    let email: String
    let phoneNum: String
    
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
}
