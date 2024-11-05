//
//  ServiceViewModel.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/27/23.
//

import UIKit
import RxSwift
import RxRelay

//struct Service {
//  var name: String
//  var identifier: String
//  var description: String
//  var imagePath: String
//}

struct ServiceCellModel {
  var identifier: String
  var description: String
  var services: [DashboardSectionItemModel]
}

protocol ServiceViewModelType {
  var description: BehaviorRelay<String?> { get set }
  var identifier: BehaviorRelay<String?> { get set }
  var services: BehaviorRelay<[DashboardSectionItemModel]> { get set }
  //var shouldRefresh: BehaviorRelay<Bool> { get }
  //var sectionModels: BehaviorRelay<[DashboardSectionModel]> { get }
  
  func navigateToService(at indexPath: IndexPath)
  
  //var sectionModels: Observable<[DashboardSectionModel]> { get }
  
}

class ServiceViewModel: ServiceViewModelType {
  private var model: ServiceCellModel
  
  var identifier: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
  var description: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
  var services: BehaviorRelay<[DashboardSectionItemModel]> = BehaviorRelay<[DashboardSectionItemModel]>(value: [])
  //var shouldRefresh: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
  let selectedServiceHandler: ((DashboardSectionItemModel) -> ())
  
  required init(model: ServiceCellModel,
                selectedServiceHandler: @escaping ((DashboardSectionItemModel) -> ())) {
    self.model = model
    
    self.selectedServiceHandler = selectedServiceHandler
    identifier.accept(model.identifier)
    description.accept(model.description)
    services.accept(model.services)
  }
  
  func navigateToService(at indexPath: IndexPath) {
    let service = services.value[indexPath.row]
    
    switch service {
    case .banner:
      break
    case .serviceItem:
      selectedServiceHandler(service)
    default:
      break
    }
    
  }
}
