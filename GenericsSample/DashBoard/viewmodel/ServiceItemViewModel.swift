//
//  ServiceItemViewModel.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/27/23.
//

import UIKit
import RxSwift
import RxRelay

struct ServiceItem {
  var name: String
  var isEnabled: Bool = true
  var identifier: String
  var description: String
  var imagePath: String
}

protocol ServiceItemViewModelType {
  var name: BehaviorRelay<String?> { get set }
  var isEnabled: BehaviorRelay<Bool> { get set }
  var identifier: BehaviorRelay<String> { get set }
  var description: BehaviorRelay<String?> { get  set}
  var imagePath: BehaviorRelay<String?> { get set }
  

}
 
class ServiceItemViewModel: ServiceItemViewModelType {
  private var model: ServiceItem
  
  var name: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
  var isEnabled: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
  var identifier: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
  var description: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
  var imagePath: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
  
  init(model: ServiceItem) {
    self.model = model
    
    name.accept(model.name)
    isEnabled.accept(model.isEnabled)
    identifier.accept(model.identifier)
    description.accept(model.description)
    imagePath.accept(model.imagePath)
  }
}
