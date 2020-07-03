//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 6/29/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    
    private let addPhotobutton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "addPhoto"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addProfilePhotoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var userNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: "twitterBlue", withImage: "person", textField: usernameTextField)
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: "twitterBlue", withImage: "person", textField: fullNameTextField)
        return view
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: "twitterBlue", withImage: "envelope", textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: "twitterBlue", withImage: "lock", textField: passwordTextField)
        return view
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Username")
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Full Name")
        return tf
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = Utilities().pressedButtons(
            withBackgroundColor: UIColor.white,
            withTitle: "Sign Up",
            withTitleColor: UIColor.init(named: "twitterBlue")!,
            withFontSize: 21,
            withCornerRadius: 10
        )
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", "  Log In")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
    }
    
    //MARK: - Selectors
    
    @objc func addProfilePhotoButtonTapped() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func signUpButtonTapped() {
        print("Signing up!!")
    }
    
    @objc func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "twitterBlue")
        
        view.addSubview(addPhotobutton)
        addPhotobutton.centerX(
            inView: view,
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 50
        )
        addPhotobutton.setDimensions(width: 150, height: 150)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let stack = UIStackView(arrangedSubviews: [
            userNameContainerView,
            fullNameContainerView,
            emailContainerView,
            passwordContainerView
        ])
        stack.axis = .vertical
        stack.spacing = 30
        
        view.addSubview(stack)
        stack.anchor(
            top: addPhotobutton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 65
        )
        
        view.addSubview(signUpButton)
        signUpButton.anchor(
            top: stack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 30,
            paddingLeft: 40,
            paddingRight: 40,
            width: 334,
            height: 50
        )
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 40,
            paddingBottom: 20,
            paddingRight: 40,
            width: 228,
            height: 16
        )
    }
}

//MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        
        addPhotobutton.layer.cornerRadius = 150 / 2
        addPhotobutton.layer.masksToBounds = true
        addPhotobutton.imageView?.contentMode = .scaleAspectFill
        addPhotobutton.imageView?.clipsToBounds = true
        addPhotobutton.layer.borderWidth = 3
        addPhotobutton.layer.borderColor = UIColor.white.cgColor
        
        self.addPhotobutton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
