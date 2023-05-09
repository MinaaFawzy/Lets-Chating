//
//  StorageManager.swift
//  Lets Chating
//
//  Created by Mo0oN on 09/05/2023.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    
    // /image/mina-email-com-profile_picture.png
    public func uploadProfilePicture(data: Data, fileName: String, completion: @escaping (Result<String,Error>)-> Void) {
        storage.child("/image/\(fileName)").putData(data, metadata: nil) { metadata, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            self.storage.child("/image/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                let urlString = url.absoluteString
                completion(.success(urlString))
            }
        }
        
    }
    
    func downloadProfilePicture(path: String, completion: @escaping (Result<URL,Error>) -> Void) {
        let refrance = storage.child(path)
        
        refrance.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(url))
            
            
        }
    }
}
