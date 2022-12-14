//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Fedor on 14.12.2022.
//

import UIKit

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Elements
    
    // MARK: - Init
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
    }
    // MARK: - Selectors
    
    @objc func showProfile() {
        print("Profile opens")
    }
    
    
    // MARK: - Setup UI
    
    func configureUI() {
        self.view.backgroundColor = .white
    }
    
    func configureNavigationBar() {
        // turned out that it is hard to change BG-color of navBar. This method works
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemPurple
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        
        // profile button
        let leftBarButton = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarButton, style: .plain, target: self, action: #selector(showProfile))
    }
    
    
    
    private func setConstraints() {
        
    }
}


