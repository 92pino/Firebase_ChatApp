//
//  NewMessageController.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/23.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: class {
  func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}

class NewMessageController: UITableViewController {

  // Mark: - Properties
  private var users = [User]()
  weak var delegate: NewMessageControllerDelegate?
  
  // Mark: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    fetchUsers()
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
    
    // 사용하지 않는 영역은 빈 뷰로
    tableView.tableFooterView = UIView()
    
    tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 80
  }
  
  // MARK: - API
  
  func fetchUsers() {
    Service.fetchUsers { users in
      self.users = users
      self.tableView.reloadData()
    }
  }
  
  // Mark: - Selectors
  @objc func handleDismissal() {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource

extension NewMessageController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
    cell.user = users[indexPath.row]
    
    return cell
  }
}

extension NewMessageController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
  }
}
