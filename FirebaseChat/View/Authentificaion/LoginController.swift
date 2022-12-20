//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Fedor on 16.12.2022.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let chatIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bubble.right")
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var emailContainerView = InputContainerView(imageName: "envelope", textField: emailTextField)
    private lazy var passwordContainerView = InputContainerView(imageName: "lock", textField: passwordTextField)
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        // part of title needs to be bold-font. So doing this through attributes
        let button = UIButton()
        let attributeString = NSMutableAttributedString(string: "Don't have an account? ",
                                                        attributes: [.font : UIFont.systemFont(ofSize: 16)])
        attributeString.append(NSAttributedString(string: "Sign Up",
                                                  attributes: [.font : UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributeString, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UI Elements
    
    // MARK: - Init
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Selectors
    
    @objc func signUpButtonPressed() {
        let signUpController = RegistrationController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    // MARK: - Methods
    
    // MARK: - Setup UIим
    
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientBackground()
        
        // icon
        self.view.addSubview(chatIconImage)
        chatIconImage.centerX(inView: self.view)
        chatIconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        chatIconImage.setDimensions(height: 100, width: 100)
        
        // text-fields and login-button
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   logInButton])
        stack.axis = .vertical
        stack.spacing = 16

        logInButton.setHeight(height: 50)
        
        self.view.addSubview(stack)
        stack.anchor(top: chatIconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingRight: 32)

        // signUp button
        self.view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32, paddingBottom: 16,
                                     paddingRight: 32)
    }
    
    func configureGradientBackground() {
        let gradiend = CAGradientLayer()
        gradiend.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradiend.locations = [0, 1]
        gradiend.frame = self.view.frame
        self.view.layer.addSublayer(gradiend)
    }
}
