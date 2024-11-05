//
//  BaseViewModel.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/12/23.
//

import UIKit
import RxRelay

protocol BaseViewModel {
//  
//  // MARK: - Properties
//    // Define common properties or methods here
//    //var list: BehaviorRelay<[CellConfigurable]> { get set }
//    //var title: String { get set }
//    
//    func fetchData()
//    //func rowCount() { get }
}

protocol DashboardBaseViewModelType {
  associatedtype Input
  associatedtype Output
  
  var input: Input { get }
  var output: Output { get }
    
  func fetchData()
}


//class BaseViewModel {
////    var input: Input
////    var output: Output
//
//    var list: BehaviorRelay<[CellConfigurable]> = BehaviorRelay(value: [])
//    var title: String = ""
//
//    func fetchData() {
//        // Implement the default behavior for fetching data here
//    }
//}
