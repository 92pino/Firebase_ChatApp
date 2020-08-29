//
//  CustomInputAccessoryView.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/29.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

class CustomInputAccessoryView: UIView {
  // Mark: - Properties
  private lazy var messageInputTextView: UITextView = {
    let tv = UITextView()
    tv.font = UIFont.systemFont(ofSize: 16)
    tv.isScrollEnabled = false
    
    return tv
  }()
  
  private lazy var sendButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Send", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitleColor(.systemPurple, for: .normal)
    button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
    
    return button
  }()
  
  private let placeholderLabel: UILabel = {
    let label = UILabel()
    label.text = "Enter Message"
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .lightGray
    
    return label
  }()
  
  // Mark: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    autoresizingMask = .flexibleHeight
    backgroundColor = .white
    
    layer.shadowOpacity = 0.25
    layer.shadowRadius = 10
    layer.shadowOffset = .init(width: 0, height: -8)
    layer.shadowColor = UIColor.lightGray.cgColor
    
    addSubview(sendButton)
    sendButton.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(4)
      $0.right.equalTo(self.snp.right).offset(-8)
      $0.width.height.equalTo(50)
    }
    
    addSubview(messageInputTextView)
    messageInputTextView.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(12)
      $0.left.equalTo(self.snp.left).offset(4)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8)
      $0.right.equalTo(sendButton.snp.left).offset(-8)
    }
    
    addSubview(placeholderLabel)
    placeholderLabel.snp.makeConstraints {
      $0.left.equalTo(messageInputTextView.snp.left).offset(4)
      $0.centerY.equalTo(messageInputTextView.snp.centerY)
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return .zero
  }
  
  // Mark: - Selectors
  @objc func handleSendMessage(_ sender: UIButton) {
    print("DEBUG: Handle send message here...")
  }
  
  @objc func handleTextInputChange(_ sender: UITextField) {
    placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
  }
}
