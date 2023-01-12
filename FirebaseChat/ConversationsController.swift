//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Fedor on 14.12.2022.
//

import UIKit
import Firebase

class ConversationsController: UIViewController {

    // MARK: - Properties
    private let reuseIdentifier = "ConversationCell"
    
    // MARK: - UI Elements
    private let conversationsTableView = UITableView()
    
    // MARK: - Init
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentificateUser()
    }
    
    // MARK: - Selectors
    
    @objc func showProfile() {
        print("DEBUG: Profile button tapped")
        logoutUser()
    }
    
    // MARK: - API
    
    func authentificateUser() {
        
        // once if user was created and it is in the database, it will be logged in by default
        // so should check this before any actions
        if Auth.auth().currentUser?.uid == nil {
            print("DEBUG: user is NOT logged in")
            presentLoginScreen()
        } else {
            print("DEBUG: user is logged in. Currend UID is \(Auth.auth().currentUser?.uid)")
        }
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Error signing out")
        }
    }
    
    // MARK: - Setup UI
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
    func configureUI() {
        configureNavigationBar()
        configureTableView()
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
    
    func configureTableView() {
//        conversationsTableView.backgroundColor = .systemCyan
        conversationsTableView.rowHeight = 80
        conversationsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        conversationsTableView.tableFooterView = UIView()
        
        conversationsTableView.delegate = self
        conversationsTableView.dataSource = self
        
        self.view.addSubview(conversationsTableView)
        conversationsTableView.frame = self.view.frame
    }
}

// MARK: - Table settings
extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "Test"
        return cell
    }
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}

