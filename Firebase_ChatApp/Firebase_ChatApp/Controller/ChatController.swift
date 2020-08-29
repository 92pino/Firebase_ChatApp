//
//  ChatController.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/29.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "MessageCell"

class ChatController: UICollectionViewController {
  
  // Mark: - Properties
  
  private let user: User
  
  private lazy var customInputView: CustomInputAccessoryView = {
    let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
    
    return iv
  }()
  
  // Mark: - Lifecycle
  
  init(user: User) {
    self.user = user
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    
    print("DEBUG: User in chat controller is \(user.username)")
  }
  
  override var inputAccessoryView: UIView? {
    get { return customInputView }
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  // MARK: - Helpers
  func configureUI() {
    collectionView.backgroundColor = .white
    configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
    
    collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.alwaysBounceVertical = true
  }
  
  // Mark: - Selectors

}

extension ChatController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
    
    return cell
  }
}

extension ChatController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 50)
  }
}