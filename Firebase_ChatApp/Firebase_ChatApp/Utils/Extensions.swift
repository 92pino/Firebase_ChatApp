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
  
  func configureNavigationBar(withTitle title: String, prefersLargeTitles: Bool) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.backgroundColor = .systemPurple
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    navigationItem.title = title
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true
    
    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
  }
}
