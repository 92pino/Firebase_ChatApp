//
//  RegistrationController.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/18.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

  // Mark: - Properties
  
  // Mark: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    view.backgroundColor = .systemPink
    navigationController?.navigationBar.isHidden = true
  }
  
  // Mark: - Selectors

}
