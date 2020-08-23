//
//  Extensions.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/19.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import JGProgressHUD

extension UIViewController {
  
  static let hud = JGProgressHUD(style: .dark)
  
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
  
  func showLoader(_ show: Bool, withText text: String? = "Loading") {
    view.endEditing(true)
    
    // progressbar
    UIViewController.hud.textLabel.text = text
    
    if show {
      UIViewController.hud.show(in: view)
    } else {
      UIViewController.hud.dismiss()
    }
  }
}
