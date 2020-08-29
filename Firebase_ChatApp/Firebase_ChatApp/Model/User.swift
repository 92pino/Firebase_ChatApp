//
//  User.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/23.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

struct User {
  let uid: String
  let profileImageUrl: String
  let username: String
  let fullname: String
  let email: String
  
  init(dictionary: [String: Any]) {
    self.uid = dictionary["uid"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    self.fullname = dictionary["fullname"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
  }
}
