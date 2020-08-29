//
//  UserCell.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/23.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class UserCell: UITableViewCell {
  
  var user: User? {
    didSet { configure() }
  }
  
  // MARK: - Properties
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .systemPurple
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 56 / 2
    
    return iv
  }()
  
  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.text = "username"
    
    return label
  }()
  
  private let fullnameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .lightGray
    label.text = "fullname"
    
    return label
  }()

  // MARK: - LifeCycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
    stack.axis = .vertical
    stack.spacing = 2
    
    [profileImageView, stack].forEach { addSubview($0) }
    
    profileImageView.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.left.equalTo(self.snp.left).offset(12)
      $0.width.height.equalTo(56)
    }
    
    stack.snp.makeConstraints {
      $0.centerY.equalTo(profileImageView)
      $0.left.equalTo(profileImageView.snp.right).offset(12)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  
  func configure() {
    guard let user = user else { return }
    fullnameLabel.text = user.fullname
    usernameLabel.text = user.username
    
    guard let url = URL(string: user.profileImageUrl) else { return }
    profileImageView.sd_setImage(with: url)
  }
}
