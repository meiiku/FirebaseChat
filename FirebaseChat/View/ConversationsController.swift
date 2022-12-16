//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Fedor on 14.12.2022.
//

import UIKit

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
    }
    // MARK: - Selectors
    
    @objc func showProfile() {
        print("Profile opens")
    }
    
    // MARK: - Setup UI
    
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
        return 2
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

