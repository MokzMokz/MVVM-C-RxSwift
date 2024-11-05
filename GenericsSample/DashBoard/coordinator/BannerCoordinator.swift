//
//  BannerCoordinator.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/21/23.
//

import UIKit

class BannerCoordinator: Coordinator {
    weak var rootViewController: UIViewController!
    var viewModel: BannerViewModelType!
    
    init(viewModel : BannerViewModelType) {
        self.viewModel = viewModel
    }
    
    func start() -> UIViewController {
        let bannerContainerVC = BannerCoordinator.instantiateViewController() as! BannerContainerViewController
        rootViewController = bannerContainerVC
        
        bannerContainerVC.viewModel = viewModel
        return bannerContainerVC
    }
}

extension BannerCoordinator : StoryboardInitializable {
    static var storyboardName: UIStoryboard.Storyboard {
        return .main
    }
}
