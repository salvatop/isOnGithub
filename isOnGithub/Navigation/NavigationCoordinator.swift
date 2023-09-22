//
//  NavigationCoordinator.swift
//  isOnGithub
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import Foundation
import UIKit

/// This class use the  coordinator design pattern to take the  responsibility for navigation out of the view controllers.
/// Implement the Coordinator protocol
final class NavigationCoordinator: Coordinator {
    
    typealias Kind = User.Kind

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func displayDefaultController() {
        let controller = UserSearchViewController()
        controller.navigationCoordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    
    
    func displayUserProfile(user: String) {
        let controller = DisplayUserProfileViewController(user: user)
        controller.navigationCoordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
}
