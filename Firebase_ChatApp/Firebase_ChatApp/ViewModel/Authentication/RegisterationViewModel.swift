//
//  RegisterationViewModel.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/20.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

struct RegisterationViewModel: AuthenticationProtocol {
  var email: String?
  var password: String?
  var fullname: String?
  var username: String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
  }
  
}
