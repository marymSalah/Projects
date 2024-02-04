//
//  FirebaseStorageService.swift
//  LabCaught
//
//  Created by Shaikha Hasan Ali Hasan Ali Mohamed on 04/01/2024.
//

import Foundation
import FirebaseStorage
import UIKit


class FirebaseStorageService {
    
    
    static let shared = FirebaseStorageService()

        private init() {}

        func fetchImage(forLogoImageName logoImageName: String, completion: @escaping (UIImage?) -> Void) {
            let storageRef = Storage.storage().reference().child("images/\(logoImageName)")
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    completion(nil)
                } else if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
        }
    
   
}
