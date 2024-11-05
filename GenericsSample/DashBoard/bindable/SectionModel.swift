//
//  SectionModel.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/12/23.
//

import UIKit
import RxDataSources


// DashBoardSection Model
struct DashboardSectionModel {
  var items: [DashboardSectionItemModel]
}

extension DashboardSectionModel: SectionModelType {
  init(original: DashboardSectionModel,
       items: [DashboardSectionItemModel]) {
    self = original
    self.items = items
  }
}

// items
enum DashboardSectionItemModel {
  case banner(viewModel: BannerViewModelType)
  case services(viewModel: ServiceViewModelType)
  case separator(viewModel: SeparatorModelType)
  case serviceItem(viewModel: ServiceItemViewModelType)
}

extension DashboardSectionItemModel {
  var identifier: String {
    switch self {
    case .banner:
      return BannerTableViewCell.reuseIdentifier
    case .services:
      return ServicesTableViewCell.reuseIdentifier
    case .serviceItem:
      return ServiceCollectionViewCell.reuseIdentifier
    case .separator:
      return SeparatorTableViewCell.reuseIdentifier
    }
  }
  
  func viewModel<T>() -> T {
    switch self {
    case let .banner(viewModel):
      return viewModel as! T
    case let .services(viewModel):
      return viewModel as! T
    case let .serviceItem(viewModel):
      return viewModel as! T
    case let .separator(viewModel):
      return viewModel as! T
    }
  }
  
  func rowHeight() -> CGFloat {
    switch self {
    case .banner:
      return 200.0
    case .services:
      return 300.0
    case .separator:
      return 10.0
    case .serviceItem:
      return 90.0
    }
  }
}
