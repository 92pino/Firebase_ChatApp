//
//  ConversationCell.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/31.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {
  
  // MARK: - Properties
  var conversation: Conversation? {
    didSet { configure() }
  }
  
  let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .lightGray
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    
    return iv
  }()
  
  let timestampLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .darkGray
    label.text = "2h"
    
    return label
  }()
  
  let usernameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    
    return label
  }()
  
  let messageTextLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    
    return label
  }()
  
  // MARK: - Lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(profileImageView)
    profileImageView.snp.makeConstraints {
      $0.left.equalTo(self.snp.left).offset(12)
      $0.width.height.equalTo(50)
      $0.centerY.equalTo(self.snp.centerY)
    }
    profileImageView.layer.cornerRadius = 50 / 2
    
    let stack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
    stack.axis = .vertical
    stack.spacing = 4
    
    addSubview(stack)
    stack.snp.makeConstraints {
      $0.left.equalTo(profileImageView.snp.right).offset(12)
      $0.right.equalTo(self.snp.right).offset(-16)
    }
    
    addSubview(timestampLabel)
    timestampLabel.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(20)
      $0.right.equalTo(self.snp.right).offset(-12)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  
  func configure() {
    guard let conversation = conversation else { return }
    let viewModel = ConversationViewModel(conversation: conversation)
    
    usernameLabel.text = conversation.user.username
    messageTextLabel.text = conversation.message.text
    
    timestampLabel.text = viewModel.timestamp
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
  }
}
