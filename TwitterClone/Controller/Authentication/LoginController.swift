//
//  LoginController.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 6/29/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "logoWhite")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: "twitterBlue", withImage: "envelope", textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: "twitterBlue", withImage: "lock", textField: passwordTextField)
        return view
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
    
    private let loginButton: UIButton = {
        let button = Utilities().pressedButtons(
            withBackgroundColor: UIColor.white,
            withTitle: "Log In",
            withTitleColor: UIColor(named: "twitterBlue")!,
            withFontSize: 21,
            withCornerRadius: 10
        )
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", "  Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func loginButtonTapped() {
        print("It's alive!!")
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "twitterBlue")
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 30
        
        view.addSubview(stack)
        stack.anchor(
            top: logoImageView.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 65
        )
        
        view.addSubview(loginButton)
        loginButton.anchor(
            top: stack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 30,
            paddingLeft: 40,
            paddingRight: 40,
            width: 334,
            height: 50
        )
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 40,
            paddingBottom: 20,
            paddingRight: 30,
            width: 228,
            height: 16
        )
    }
}
