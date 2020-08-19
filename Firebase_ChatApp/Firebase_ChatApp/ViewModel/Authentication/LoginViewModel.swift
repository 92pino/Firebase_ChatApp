//
//  LoginViewModel.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/20.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

protocol AuthenticationProtocol {
  var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {
  var email: String?
  var password: String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false && password?.isEmpty == false
  }
}
