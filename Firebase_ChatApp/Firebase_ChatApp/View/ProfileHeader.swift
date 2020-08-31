//
//  ProfileHeader.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/31.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import SnapKit

protocol ProfileHeaderDelegate: class {
  func dismissController()
}

class ProfileHeader: UIView {
  
  // Mark: - Properties
  
  weak var delegate: ProfileHeaderDelegate?
  
  private let dismissButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "xmark"), for: .normal)
    button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
    button.tintColor = .white
    button.imageView?.widthAnchor.constraint(equalToConstant: 22).isActive = true
    button.imageView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
    return button
  }()
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFill
    iv.layer.borderColor = UIColor.white.cgColor
    iv.layer.borderWidth = 4.0
    return iv
  }()
  
  private let fullnameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textColor = .white
    label.textAlignment = .center
    label.text = "fullname"
    return label
  }()
  
  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .center
    label.text = "@fullname"
    return label
  }()
  
  // Mark: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    configureGradientLayer()
    
    profileImageView.layer.cornerRadius = 200 / 2
//    profileImageView.snp.makeConstraints {
//      $0.centerX.equalTo(self.snp.centerX)
//      $0.top.equalTo(self.snp.top).offset(96)
//      $0.width.height.equalTo(200)
//    }
    
    addSubview(profileImageView)
    
    let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
    stack.axis = .vertical
    stack.spacing = 4
    
    addSubview(stack)
//    stack.snp.makeConstraints {
//      $0.top.equalTo(profileImageView.snp.bottom).offset(16)
//      $0.centerX.equalTo(self.snp.centerX)
//    }
    
    addSubview(dismissButton)
    dismissButton.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(44)
      $0.left.equalTo(self.snp.left).offset(12)
      $0.width.height.equalTo(48)
    }
  }
  
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0, 1]
    layer.addSublayer(gradient)
    gradient.frame = bounds
  }
  
  // Mark: - Selectors
  @objc func handleDismissal(_ sender: UIButton) {
    delegate?.dismissController()
  }
}
