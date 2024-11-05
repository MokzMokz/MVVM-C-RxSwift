//
//  ServiceCoordinator.swift
//  GenericsSample
//
//  Created by COLLABERA on 10/5/23.
//

import UIKit

class ServiceCoordinator: Coordinator {
  weak var rootViewController: UIViewController!
  var viewModel: ServiceItemViewModelType!
  
  init(viewModel : ServiceItemViewModelType) {
    self.viewModel = viewModel
  }
  
  func start() -> UIViewController {
    let serviceVC = ServiceCoordinator.instantiateViewController() as! ServiceContainerViewController
    rootViewController = serviceVC
    
    serviceVC.viewModel = viewModel
    return serviceVC
  }
}

extension ServiceCoordinator : StoryboardInitializable {
  static var storyboardName: UIStoryboard.Storyboard {
    return .main
  }
}
