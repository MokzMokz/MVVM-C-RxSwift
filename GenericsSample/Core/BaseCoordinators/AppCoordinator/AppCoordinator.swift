//
//  AppCoordinator.swift
//  MVVM-C-Example
//
//  Created by Osama Bin Bashir on 12/10/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator : Coordinator{
    private var window : UIWindow?
    private var navigationController: UINavigationController!
    private var dashBoardCoordinator : DashBoardCoordinator!
    
    init(window : UIWindow) {
        self.window = window
    }
    
    @discardableResult
    func start()->UIViewController{
        dashBoardCoordinator = DashBoardCoordinator()
        let mainVC = dashBoardCoordinator.start()
//        navigationController = UINavigationController(rootViewController: mainVC)
//        navigationController.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return mainVC
    }
}
