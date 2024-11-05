//
//  BindableType.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/21/23.
//

import Foundation
import UIKit

// Identifiable
protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String { String(describing: Self.self)}
}


// BindableType for cell or item
protocol BindableType {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  
  func bindViewModel()
}

extension BindableType where Self: UITableViewCell {
  mutating func bindViewModel(to model: Self.ViewModelType) {
    viewModel = model
    bindViewModel()
  }
}

extension BindableType where Self: UICollectionViewCell {
  mutating func bindViewModel(to model: Self.ViewModelType) {
    viewModel = model
    bindViewModel()
  }
}


// DashboardBindableType for cell or item
protocol DashboardBindableType: Identifiable {
  func bindItemModel(to itemModel: DashboardSectionItemModel)
}

extension DashboardBindableType where Self: UITableViewCell & BindableType {
  func bindItemModel(to itemModel: DashboardSectionItemModel) {
    guard let viewModel: ViewModelType = itemModel.viewModel() else {
      fatalError("viewmodel not match@")
    }
    
    var cell = self
    cell.bindViewModel(to: viewModel)
  }
}

extension DashboardBindableType where Self: UICollectionViewCell & BindableType {
  func bindItemModel(to itemModel: DashboardSectionItemModel) {
    guard let viewModel: ViewModelType = itemModel.viewModel() else {
      fatalError("viewmodel not match@")
    }
    var cell = self
    cell.bindViewModel(to: viewModel)
  }
}
