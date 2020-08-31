//
//  MessageCell.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/29.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import SnapKit

class MessageCell: UICollectionViewCell {
  
  // Mark: - Properties
  
  var message: Message? {
    didSet { configure() }
  }
  
  var bubbleLeftAnchor: NSLayoutConstraint!
  var bubbleRightAnchor: NSLayoutConstraint!
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    
    return iv
  }()
  
  private let textView: UITextView = {
    let tv = UITextView()
    tv.backgroundColor = .clear
    tv.font = .systemFont(ofSize: 16)
    tv.isScrollEnabled = false
    tv.isEditable = false
    tv.textColor = .white
    tv.text = "Some test message for now.."
    
    return tv
  }()
  
  private let bubbleContainer: UIView = {
    let view = UIView()
    view.backgroundColor = .systemPurple
    
    return view
  }()
  
  // Mark: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(profileImageView)
    
    profileImageView.snp.makeConstraints {
      $0.left.equalTo(self.snp.left).offset(8)
      $0.bottom.equalTo(self.snp.bottom).offset(4)
      
      $0.width.height.equalTo(32)
    }
    profileImageView.layer.cornerRadius = 32 / 2
    
    addSubview(bubbleContainer)
    bubbleContainer.layer.cornerRadius = 12
    bubbleContainer.snp.makeConstraints {
      $0.top.equalTo(self.snp.top)
      $0.bottom.equalTo(self.snp.bottom)
      $0.width.lessThanOrEqualTo(250)
    }
    
    bubbleContainer.addSubview(textView)
    textView.snp.makeConstraints {
      $0.edges.equalTo(bubbleContainer.snp.edges).inset(UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12))
    }
    
    bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
    bubbleLeftAnchor.isActive = false
    
    bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
    bubbleRightAnchor.isActive = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  
  func configure() {
    guard let message = message else { return }
    let viewModel = MessageViewModel(message: message)
    
    bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
    textView.textColor = viewModel.messageTextColor
    textView.text = message.text
    
    bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
    bubbleRightAnchor.isActive = viewModel.rightAnchorActive
    
    profileImageView.isHidden = viewModel.shouldHideProfileImage
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
  }
  
  // Mark: - Selectors
}
