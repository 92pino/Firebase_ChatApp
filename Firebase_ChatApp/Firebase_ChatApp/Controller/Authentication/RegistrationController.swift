//
//  RegistrationController.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/18.
//  Copyright © 2020 pino. All rights reserved.
//

import UIKit
import SnapKit

class RegistrationController: UIViewController {

  // Mark: - Properties
  
  private var viewModel = RegisterationViewModel()
  
  private let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    button.imageView?.clipsToBounds = true
    button.clipsToBounds = true
    
    return button
  }()
  
  private lazy var emailContainerView: UIView = {
    return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
  }()
  
  private let emailTextField = CustomTextField(placeholder: "Email")
  
  private lazy var fullnameContainerView: UIView = {
    return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
  }()
  
  private let fullnameTextField = CustomTextField(placeholder: "Full Name")
  
  private lazy var usernameContainerView: UIView = {
    return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
  }()
  
  private let usernameTextField = CustomTextField(placeholder: "User Name")
  
  private lazy var passwordContainerView: InputContainerView = {
    return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
  }()
  
  private let passwordTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    
    return tf
  }()
  
  private let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    button.setTitleColor(.white, for: .normal)
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.isEnabled = false
    
    return button
  }()
  
  private let alreadyHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Already have an account?   ",
                                                    attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                 .foregroundColor: UIColor.white])
    
    attributedTitle.append(NSAttributedString(string: "Log In",
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                           .foregroundColor: UIColor.white]))
    
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
    
    return button
  }()
  
  // Mark: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    configureNotificationObservers()
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    configureGradientLayer()
    
    let guide = view.safeAreaLayoutGuide
    
    [plusPhotoButton].forEach { view.addSubview($0) }
    
    plusPhotoButton.snp.makeConstraints {
      $0.centerX.equalTo(view.snp.centerX)
      $0.top.equalTo(guide.snp.top).offset(32)
      $0.height.width.equalTo(200)
    }
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                               fullnameContainerView,
                                               usernameContainerView,
                                               passwordContainerView,
                                               signUpButton])
    stack.axis = .vertical
    stack.spacing = 16
    
    view.addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
      $0.left.equalToSuperview().offset(32)
      $0.right.equalToSuperview().offset(-32)
    }
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.snp.makeConstraints {
      $0.bottom.equalTo(guide.snp.bottom).offset(16)
      $0.centerX.equalToSuperview()
    }
  }
  
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
  
  // Mark: - Selectors

  @objc func handleSelectPhoto(_ sender: UIButton) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
  }
  
  @objc func handleShowLogIn(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func textDidChange(_ sender: UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else if sender == passwordTextField {
      viewModel.password = sender.text
    } else if sender == fullnameTextField {
      viewModel.fullname = sender.text
    } else {
      viewModel.username = sender.text
    }
    
    checkFormStatus()
  }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    print("DEBUG: \(info)")
    let image = info[.originalImage] as? UIImage
    plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    plusPhotoButton.layer.borderColor = UIColor.white.cgColor
    plusPhotoButton.layer.borderWidth = 3.0
    plusPhotoButton.layer.cornerRadius = 200 / 2
    
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - <#controller#>

extension RegistrationController: AuthenticationControllerProtocol {
  func checkFormStatus() {
    if viewModel.formIsValid {
      signUpButton.isEnabled = true
      signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    } else {
      signUpButton.isEnabled = false
      signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
  }
}
