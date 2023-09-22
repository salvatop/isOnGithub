//
//  UserSearchViewController.swift
//  isOnGithub
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import UIKit

final class UserSearchViewController: UIViewController {
    
    weak var navigationCoordinator: NavigationCoordinator?
    
    private let api = UserServiceApi()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Github User Search"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var userNotFoundLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: view.bounds.width/2 - 100, y: 100, width: 200, height: 50))
        label.text = "Not found"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        
        view.addSubview(userNotFoundLabel)
    }
}

// MARK: - UISearchBarDelegate
extension UserSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let username = searchBar.text else { return }

        Task {
            do {
                let result = try await api.searchByUsername(username: username)
                DispatchQueue.main.async {
                    if result.contains("error") {
                        self.userNotFoundLabel.isHidden = false
                    } else {
                        self.navigationCoordinator?.displayUserProfile(user: username)
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async(execute: { [weak self] in
                searchBar.resignFirstResponder()
                self?.userNotFoundLabel.isHidden = true
            })
        }
    }
}

