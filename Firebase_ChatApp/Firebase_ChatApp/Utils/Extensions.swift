//
//  Extensions.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/19.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

extension UIViewController {
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
}
