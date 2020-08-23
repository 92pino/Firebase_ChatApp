//
//  ConversationsController.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/18.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

private let reuseIdentifier = "ConversationCell"

class ConversationsController: UIViewController {
  
  // Mark: - Properties
  private let tableView = UITableView()
  
  private let newMessageButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.backgroundColor = .systemPurple
    button.tintColor = .white
    button.imageView?.snp.makeConstraints({
      $0.width.height.equalTo(24)
    })
    button.addTarget(self, action: #selector(showNewMessageController), for: .touchUpInside)
    
    return button
  }()
  
  // Mark: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    authenticateUser()
  }
  
  // MARK: - Helpers
  
  func presentLoginScreen() {
    DispatchQueue.main.async {
      let controller = LoginController()
      let nav = UINavigationController(rootViewController: controller)
      nav.modalPresentationStyle = .fullScreen
      self.present(nav, animated: true, completion: nil)
    }
  }
  
  func configureUI() {
    view.backgroundColor = .white
    
    configureNavigationBar()
    configureTableView()
    
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
    
    let guide = view.safeAreaLayoutGuide
    
    view.addSubview(newMessageButton)
    newMessageButton.snp.makeConstraints {
      $0.bottom.equalTo(guide.snp.bottom).offset(-16)
      $0.right.equalTo(view.snp.right).offset(-24)
      $0.width.height.equalTo(56)
    }
    newMessageButton.layer.cornerRadius = 56 / 2
  }
  
  func configureTableView() {
    tableView.backgroundColor = .white
    tableView.rowHeight = 80
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.frame = view.frame
  }
  
  func configureNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.backgroundColor = .systemPurple
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Messages"
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true
    
    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
  }
  
  // MARK: - API
  func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      presentLoginScreen()
    } else {
      print("DEBUG: User id is \(Auth.auth().currentUser?.uid)")
    }
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
      presentLoginScreen()
    } catch {
      print("DEBUG: Error signing out..")
    }
  }
  
  // Mark: - Selectors
  @objc func showNewMessageController(_ sender: UIButton) {
    let controller = NewMessageController()
    let nav = UINavigationController(rootViewController: controller)
    present(nav, animated: true, completion: nil)
  }
  
  @objc func showProfile(_ sender: UIBarButtonItem) {
    logout()
  }
}

extension ConversationsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    cell.textLabel?.text = "Test"
    
    return cell
  }
  
  
}

extension ConversationsController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
  }
}
