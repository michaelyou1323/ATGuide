//
//  FavObjectDemo.swift
//  ATGuide
//
//  Created by Michaelyoussef on 25/12/2023.
//

import Firebase

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {}
    
    func fetchFavPlans(userID: String, completion: @escaping ([String: [String: Any]]) -> Void) {
        let ref = Database.database().reference().child("FavPlans").child(userID)
        
        ref.observeSingleEvent(of: .value) { snapshot in
            if let plans = snapshot.value as? [String: [String: Any]] {
                completion(plans)
            } else {
                completion([:])
            }
        }
    }
}
  
