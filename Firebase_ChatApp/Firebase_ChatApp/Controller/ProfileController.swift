//
//  ProfileController.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/31.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "ProfileCell"

class ProfileController: UITableViewController {

  // Mark: - Properties
  
  private var user: User?
  
  private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
  
  // Mark: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configuerUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
  }
  
  // Mark: - Selectors
  
  // MARK: - API
  
  func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Service.fetchUser(withUid: uid) { user in
      self.user = user
    }
  }
  
  // MARK: - Helpers
  
  func configuerUI() {
    tableView.backgroundColor = .white
    
    tableView.tableHeaderView = headerView
    headerView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView()
    tableView.contentInsetAdjustmentBehavior = .never
  }

}

extension ProfileController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    
    return cell
  }
}

extension ProfileController: ProfileHeaderDelegate {
  func dismissController() {
    dismiss(animated: true, completion: nil)
  }
}
