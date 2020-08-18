//
//  InputContainerView.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/19.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import SnapKit

class InputContainerView: UIView {
  
  init(image: UIImage?, textField: UITextField) {
    super.init(frame: .zero)
    heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    let iv = UIImageView()
    iv.image = image
    iv.tintColor = .white
    iv.alpha = 0.87
    
    addSubview(iv)
    iv.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.left.equalTo(self.snp.left).offset(8)
      $0.width.height.equalTo(24)
    }
    
    addSubview(textField)
    textField.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.left.equalTo(iv.snp.right).offset(8)
      $0.bottom.equalToSuperview().offset(-8)
      $0.right.equalToSuperview()
    }
    
    let dividerView = UIView()
    dividerView.backgroundColor = .white
    addSubview(dividerView)
    dividerView.snp.makeConstraints {
      $0.left.equalToSuperview().offset(8)
      $0.bottom.right.equalToSuperview()
      $0.height.equalTo(0.75)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
