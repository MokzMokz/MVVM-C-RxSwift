//
//  DashBoardCoordinator.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/12/23.
//

import UIKit
import RxSwift



class DashBoardCoordinator: Coordinator {
  weak var navigationController: UINavigationController!
  var viewModel: DashBoardViewModel?
  private let disposeBag = DisposeBag()
  
  func start() -> UIViewController {
    let dashBoardVC = DashBoardCoordinator.instantiateViewController() as! DashBoardViewController
    let nav = UINavigationController(rootViewController: dashBoardVC)
    navigationController = nav
    
    let dashboardViewModel = DashBoardViewModel()
    dashBoardVC.viewModel = dashboardViewModel
    viewModel = dashboardViewModel
    
    viewModel?
      .output
      .showScreen
      .drive(onNext: { [weak self] screen in
        guard let self = self else { return }
        self.showNextScreen(screen: screen)
      })
      .disposed(by: disposeBag)
    
    viewModel = dashboardViewModel
    return nav
  }
  
  private func showNextScreen(screen: DashBoardScreenFlow?) {
    guard let screen = screen else { return }
    switch screen {
    case let .gotoBanner(data):
      gotoBanner(data)
    case .navigationPop:
      navigationPop()
    case .dismissCurrent:
      break
    case let .gotoService(data):
      gotoService(data)
    }
  }
}

extension DashBoardCoordinator {
  private func navigationPop() {
    navigationController.popViewController(animated: true)
  }
  
  private func gotoBanner(_ data: BannerViewModelType) {
    let dashBoardCoor = BannerCoordinator(viewModel: data)
    let dashBoardVC = dashBoardCoor.start()
    navigationController.pushViewController(dashBoardVC, animated: true)
  }
  
  private func gotoService(_ data: ServiceItemViewModelType) {
    let dashBoardCoor = ServiceCoordinator(viewModel: data)
    let dashBoardVC = dashBoardCoor.start()
    navigationController.pushViewController(dashBoardVC, animated: true)
  }
}

extension DashBoardCoordinator : StoryboardInitializable {
  static var storyboardName: UIStoryboard.Storyboard {
    return .main
  }
}
