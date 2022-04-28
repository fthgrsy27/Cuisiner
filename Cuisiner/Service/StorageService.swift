//
//  StorageService.swift
//  Cuisiner
//
//  Created by Fatih Gursoy on 5.04.2022.
//

import Foundation
import Firebase

class StorageService {
    
    static let shared: StorageService = StorageService()
    private let storage = Storage.storage()
    
    private init() { }

}

extension StorageService {
    
    func imageUpload(to folder: myStorage, image: UIImage, completion: @escaping ((String?) -> Void)) {
     
        if let data = image.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let storageRef = storage.reference().child(folder.name)
            let imageRef = storageRef.child("\(uuid).jpeg")
            
            imageRef.putData(data, metadata: nil) { data, error in
                
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url!.absoluteString
                            completion(imageUrl)
                        }
                    }
                }
            }
        }
    }
    
}


