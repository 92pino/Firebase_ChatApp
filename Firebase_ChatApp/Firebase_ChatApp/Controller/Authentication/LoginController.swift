//
//  LoginController.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/18.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import SnapKit

protocol AuthenticationControllerProtocol {
  func checkFormStatus()
}

class LoginController: UIViewController {
  
  // Mark: - Properties
  
  private var viewModel = LoginViewModel()
  
  private let iconImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "chat")
    
    return imageView
  }()
  
  private lazy var emailContainerView: UIView = {
    return InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
  }()
  
  private let emailTextField = CustomTextField(placeholder: "Email")
  
  private lazy var passwordContainerView: InputContainerView = {
    return InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
  }()
  
  private let passwordTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    
    return tf
  }()
  
  private let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log In", for: .normal)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    button.setTitleColor(.white, for: .normal)
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.isEnabled = false
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    
    return button
  }()
  
  private let dontHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Don't have an account?   ",
                                                    attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                 .foregroundColor: UIColor.white])
    
    attributedTitle.append(NSAttributedString(string: "Sign Up",
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                           .foregroundColor: UIColor.white]))
    
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    
    return button
  }()
  
  // Mark: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    
    configureGradientLayer()
    
    let guide = view.safeAreaLayoutGuide
    
    [iconImage].forEach { view.addSubview($0) }
    
    iconImage.snp.makeConstraints {
      $0.centerX.equalTo(view.snp.centerX)
      $0.top.equalTo(guide.snp.top).offset(32)
      $0.height.equalTo(120)
      $0.width.equalTo(120)
    }
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
    stack.axis = .vertical
    stack.spacing = 16
    
    view.addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.top.equalTo(iconImage.snp.bottom).offset(32)
      $0.left.equalToSuperview().offset(32)
      $0.right.equalToSuperview().offset(-32)
    }
    
    view.addSubview(dontHaveAccountButton)
    dontHaveAccountButton.snp.makeConstraints {
      $0.bottom.equalTo(guide.snp.bottom).offset(16)
      $0.centerX.equalToSuperview()
    }
    
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
  
  // Mark: - Selectors
  @objc func handleLogin() {
    print("DEBUG: Handle login here..")
  }
  
  @objc func handleShowSignUp(_ sender: UIButton) {
    let controller = RegistrationController()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func textDidChange(_ sender: UITextField) {
    print("DEBUG: \(sender)")
    if (sender == emailTextField) {
      viewModel.email = sender.text
    } else {
      viewModel.password = sender.text
    }
    
    checkFormStatus()
  }

}

// MARK: - <#controller#>

extension LoginController: AuthenticationControllerProtocol {
  func checkFormStatus() {
    if viewModel.formIsValid {
      loginButton.isEnabled = true
      loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    } else {
      loginButton.isEnabled = false
      loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
  }
}
