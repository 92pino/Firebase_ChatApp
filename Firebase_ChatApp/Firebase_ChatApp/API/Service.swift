//
//  Service.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/23.
//  Copyright © 2020 pino. All rights reserved.
//

import Firebase

struct Service {
  
  static func fetchUsers(completion: @escaping([User]) -> ()) {
    var users = [User]()
    Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
      snapshot?.documents.forEach({ document in
        
        let dictionary = document.data()
        let user = User(dictionary: dictionary)
        
        users.append(user)
        completion(users)
        
      })
    }
  }
  
}
