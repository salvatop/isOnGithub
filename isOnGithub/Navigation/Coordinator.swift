//
//  Coordinator.swift
//  isOnGithub
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import Foundation
import UIKit

/// Interface to access the UINavigation controller
protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func displayDefaultController()
}
