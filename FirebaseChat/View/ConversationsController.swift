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

    private func configureUI() {
        self.view.backgroundColor = .cyan
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        
        let leftBarButton = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarButton, style: .plain, target: self, action: #selector(showProfile))
    }

    private func setConstraints() {
        
    }
}


