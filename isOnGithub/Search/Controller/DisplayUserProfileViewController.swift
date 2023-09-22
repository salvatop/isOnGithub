//
//  DisplayUserProfileViewController.swift
//  isOnGithub
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import UIKit
import SDWebImage

final class DisplayUserProfileViewController: UIViewController {
    
    private let api = UserServiceApi()
    
    weak var navigationCoordinator: NavigationCoordinator?
    
    private lazy var user = [User]()
    private lazy var username = String()
    
    private lazy var userProfileView = UserProfileView()
    
    init(user: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = userProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = username
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Task { [weak self] in
            do {
                guard let username = self?.username,
                      let user = try await self?.api.getUserByUsername(username: username).get() else { return }
                self?.user = [user]
                self?.setupUI()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupUI() {
        if let url = user.first?.avatarUrl {
            userProfileView.avatar.sd_setImage(with: URL(string: url))
        }
        
        userProfileView.name.text = user.first?.name
        userProfileView.bio.text = user.first?.bio
        
    }
}

