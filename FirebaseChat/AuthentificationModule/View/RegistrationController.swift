//
//  RegistrationController.swift
//  FirebaseChat
//
//  Created by Fedor on 16.12.2022.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    // MARK: - UI Elements
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "addPhoto"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var emailContainerView = InputContainerView(imageName: "envelope", textField: emailTextField)
    private lazy var fullNameContainerView = InputContainerView(imageName: "person", textField: fullnameTextField)
    private lazy var usernameContainerView = InputContainerView(imageName: "person", textField: usernameTextField)
    private lazy var passwordContainerView = InputContainerView(imageName: "lock", textField: passwordTextField)
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.isEnabled = false
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        // part of title needs to be bold-font. So doing this through attributes
        let button = UIButton()
        let attributeString = NSMutableAttributedString(string: "Already have an account? ",
                                                        attributes: [.font : UIFont.systemFont(ofSize: 16)])
        attributeString.append(NSAttributedString(string: "Sign In",
                                                  attributes: [.font : UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributeString, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    // MARK: - Init
    
    override func viewDidLayoutSubviews() {
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPhotoButton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        alreadyHaveAccountButton.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc func selectPhoto() {
        print("addPhotoButtonPressed")
        
        // selected image becomes an avatar - the method described in UIImagePickerControllerDelegate.extension
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleShowSignIn() {
        print("showSignIn")
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    
    func checkTextFieldsStatus() {
        // if both textfields are filled, logIn button becomes enabledЦ
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
    // observer for textfields
    @objc func textDidChange(sender: UITextField) {
        print("DEBUG: sender text is \(sender.text)")
        
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        checkTextFieldsStatus()
    }
    
    @objc func handleSignUp() {
        // checking if every user's parameter exists
        guard let email = emailTextField.text, let password = passwordTextField.text,
              let username = usernameTextField.text?.lowercased(), let fullname = fullnameTextField.text else { return }
        guard let profileImage = profileImage else { return }
        
        // creates a compressed image
        guard let imageData = profileImage.jpegData(compressionQuality: 0.5) else { return }
        
        // creates smth like cache-sum
        let filename = NSUUID().uuidString
        
        // creates a folder "profile_images" and put there filenames from previous step
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                print("DEBUG: failed to upload image with error \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                // creating a user
                // when creating method is called, it goes to server and returns any result and error(?)
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: failed to upload image with error \(error.localizedDescription)")
                        return
                    }
                    
                    // getting UID (user if) from server response
                    guard let uid = result?.user.uid else { return }
                    
                    let data = ["email" : email,
                                "fullname" : fullname,
                                "username" : username,
                                "uid" : uid,
                                "imageProfileURL" : profileImageUrl] as [String : Any]
                }
            }
        }
    }
    
    
    // MARK: - Setup UI
    
    private func configureUI() {
        configureGradientBackground()
        
        // addPhotoButton
        self.view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: self.view)
        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        addPhotoButton.setDimensions(height: 200, width: 200)
        
        // text-fields and login-button
        let stack = UIStackView(arrangedSubviews: [emailContainerView, fullNameContainerView,
                                                   usernameContainerView, passwordContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        self.view.addSubview(stack)
        stack.centerY(inView: self.view)
        stack.anchor(left: view.leftAnchor, right: view.rightAnchor,
                     paddingLeft: 32, paddingRight: 32)
        
        signUpButton.setHeight(height: 50)
        
        // alreadyHaveAccountButton
        self.view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
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
// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        self.profileImage = selectedImage
        
        //selected image is set to avatar
        addPhotoButton.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 5
        addPhotoButton.layer.cornerRadius = 200/2
        
        dismiss(animated: true)
        print("image selected")
    }
}
