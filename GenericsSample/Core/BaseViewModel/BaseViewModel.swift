//
//  BaseViewModel.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/12/23.
//

import UIKit

protocol ViewModel: AnyObject {
  
  // MARK: - Properties
    // Define common properties or methods here
    var title: String { get set }
    func fetchData()
}

class BaseViewModel: ViewModel {
    var title: String = ""
        
    func fetchData() {
        // Implement the default behavior for fetching data here
    }
}
