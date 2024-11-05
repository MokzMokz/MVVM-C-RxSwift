//
//  DashBoardViewModel.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/12/23.
//

import UIKit
import RxSwift
//import RxRelay
import RxCocoa
import RxDataSources

enum DashBoardScreenFlow {
  case navigationPop
  case dismissCurrent
  case gotoBanner(data: BannerViewModelType)
  case gotoService(data: ServiceItemViewModelType)
}

class DashBoardViewModel: DashboardBaseViewModelType {
  struct Input {
    let didSelectItem: AnyObserver<DashboardSectionItemModel>
    let viewDidLoad: AnyObserver<Bool>
    //      let emptyPrimaryButtonHandler: AnyObserver<GChatMessageListEmptyViewMode>
    //      let didSubmitTerms: AnyObserver<Void>
  }
  
  struct Output {
    let shouldHideLoading: Driver<Bool>
    let showScreen: Driver<DashBoardScreenFlow?>
    let sectionModels: Driver<[DashboardSectionModel]>
    var rowHeight: Driver<[CGFloat]>
    //      let tableBackgroundView: Driver<GChatMessageListEmptyViewType?>
  }
  
  fileprivate struct Subject {
    let didSelectItem: PublishSubject<DashboardSectionItemModel>
    let shouldHideLoading: BehaviorSubject<Bool>
    let viewDidLoad: PublishSubject<Bool>
    let showScreen: PublishSubject<DashBoardScreenFlow?>
    let sectionModels: BehaviorSubject<[DashboardSectionModel]>
    var rowHeight: BehaviorSubject<[CGFloat]>
    
  }
  
  var input: Input
  var output: Output
  private var subject: Subject
  private let disposeBag = DisposeBag()
  
  
  init() {
    self.subject = createSubject()
    self.input = createInput(subject: subject)
    self.output = createOutput(subject: subject)
    
    setupBindings()
  }
  
  private func setupBindings() {
    
    subject
      .didSelectItem
      .bind { [weak self] itemModel in
        guard let self = self else { return }
        switch itemModel {
        case let .banner(data):
          self.subject.showScreen.onNext(.gotoBanner(data: data))
        default:
          break
        }
      }.disposed(by: disposeBag)
    
//    let rowHeightsObservable = try? subject.sectionModels.value().map { sectionModel in
//      return sectionModel.items.map { itemModel  in
//         itemModel.rowHeight()
//      }
//    }
 


    //subject.rowHeight.onNext()

    //rowHeights = rowHeightsObservable.asDriver(onErrorJustReturn: [])
    //        subject.didTapBack
    //          .bind(onNext: { [weak self] _ in
    //            guard let self = self else { return }
    //            self.subject.showScreen.onNext(.navigationPop)
    //          })
    //          .disposed(by: disposeBag)
    //
    //        subject
    //          .viewDidLoad
    //          .bind(onNext: { [weak self] _ in
    //            guard let self = self else { return }
    //            //self.subject.shouldHideTabBar.onNext(())
    //          })
    //          .disposed(by: disposeBag)
    
    fetchData()
  }
  
  func fetchData() {
    var sectionItemModel = [DashboardSectionItemModel]()
    
    // serviceItem
    let google = ServiceItem(name: "Google",
                                  identifier: "1",
                                  description: "google",
                                  imagePath: "https://via.placeholder.com/100x100.png?text=google")
    let yahoo = ServiceItem(name: "Yahoo",
                             identifier: "2",
                             description: "yahoo",
                             imagePath: "https://via.placeholder.com/100x100.png?text=yahoo")
    
    let gmail = ServiceItem(name: "Gmail",
                            identifier: "3",
                            description: "gmail",
                            imagePath: "https://via.placeholder.com/100x100.png?text=gmail")
    
    
    let googleItemModel = ServiceItemViewModel(model: google)
    let yahooItemModel = ServiceItemViewModel(model: yahoo)
    let gmailItemModel = ServiceItemViewModel(model: gmail)
    
    var services = [DashboardSectionItemModel]()
    services.append(.serviceItem(viewModel: googleItemModel))
    services.append(.serviceItem(viewModel: yahooItemModel))
    services.append(.serviceItem(viewModel: gmailItemModel))
    services.append(.serviceItem(viewModel: googleItemModel))
    services.append(.serviceItem(viewModel: yahooItemModel))
    services.append(.serviceItem(viewModel: gmailItemModel))
    
    let serviceBanner = ServiceCellModel(identifier: "1",
                                         description: "all services",
                                         services: services)
    let serviceViewModel = ServiceViewModel(model: serviceBanner) { [weak self] itemModel in
      switch itemModel {
      case .serviceItem:
        self?.subject.showScreen.onNext(.gotoService(data: itemModel.viewModel()))
      default:
        break
      }
      
    }
    sectionItemModel.append(.services(viewModel: serviceViewModel))
    
    // banner
    let modelBanner = BannerCellModel(imagePath: "https://via.placeholder.com/728x90.png",
                                      identifier: BannerTableViewCell.reuseIdentifier,
                                      description: "Sample Banner 90")
    let cellViewModel = BannerViewModel(model: modelBanner)
    sectionItemModel.append(.banner(viewModel: cellViewModel))
    
    // separator
    let separatorViewModel = SeparatorViewModel()
    sectionItemModel.append(.separator(viewModel: separatorViewModel))
    
    // banner2
    let modelBanner2 = BannerCellModel(imagePath: "https://via.placeholder.com/728x100.png",
                                       identifier: BannerTableViewCell.reuseIdentifier,
                                       description: "Sample Banner 100")
    let cellViewModel2 = BannerViewModel(model: modelBanner2)
    sectionItemModel.append(.banner(viewModel: cellViewModel2))
    
    subject.sectionModels.onNext([DashboardSectionModel(items: sectionItemModel)])
    
//    let mappedObservable = subject.sectionModels.map { dashboardSections in
//      // Apply your transformation logic here to map [DashboardSectionModel] to another type
//      return dashboardSections.map { sectionModel in
//        // Inside this map, you can further transform each DashboardSectionModel
//        return sectionModel.items.map { itemModel in
//          // Map each DashboardSectionItemModel to your desired output type
//          return itemModel.rowHeight()
//        }
//      }
//    }
    
//    subject.sectionModels.
    
//    var rowHeightsObservable = subject.sectionModels.ite { sectionModel in
//      return sectionModel.items.map { itemModel  in
//        itemModel.rowHeight()
//      }
//    }
    
//    output.rowHeight = rowHeightsObservable
//    subject.rowHeight = subject.sectionModels.map { models in
//      return models.map { model in
//        // Calculate height for each row
//        return model.items.map { [weak self] itemModel in
//
//          guard let self = self else { return }
//          return self.heightForRow(with: itemModel)
//        }
//      }
//    }
  }
  
}

extension DashBoardViewModel {
  func heightForRow(row: Int) -> CGFloat {
    guard let sectionModel = try? subject.sectionModels.value().first else {
      return UITableView.automaticDimension
    }
    
    let itemModel = sectionModel.items[row]
    switch itemModel {
    case .banner:
      return 200
    case .services:
      return Constants.calculateheight(row: Float(Constants.row))
    case .separator:
      return 10
    case .serviceItem:
      return 90
    }
  }
  
  func heightForRow(with itemModel: DashboardSectionItemModel) -> CGFloat {
    switch itemModel {
    case .banner:
      return 200
    case .services:
      return 270
    case .separator:
      return 10
    case .serviceItem:
      return 90
    }
  }
}

fileprivate func createSubject() -> DashBoardViewModel.Subject {
  return DashBoardViewModel.Subject(didSelectItem: PublishSubject<DashboardSectionItemModel>(),
                                    shouldHideLoading: BehaviorSubject<Bool>(value: true),
                                    viewDidLoad: PublishSubject<Bool>(),
                                    showScreen: PublishSubject<DashBoardScreenFlow?>(),
                                    sectionModels: BehaviorSubject<[DashboardSectionModel]>(value: []),
                                    rowHeight: BehaviorSubject<[CGFloat]>(value: []))
}

fileprivate func createInput(subject: DashBoardViewModel.Subject) -> DashBoardViewModel.Input {
  return  DashBoardViewModel.Input(didSelectItem: subject.didSelectItem.asObserver(),
                                   viewDidLoad: subject.viewDidLoad.asObserver())
}

fileprivate func createOutput(subject: DashBoardViewModel.Subject) -> DashBoardViewModel.Output {
  return DashBoardViewModel.Output(shouldHideLoading: subject.shouldHideLoading.asDriver(onErrorJustReturn: true),
                                   showScreen: subject.showScreen.asDriver(onErrorJustReturn: nil),
                                   sectionModels: subject.sectionModels.asDriver(onErrorJustReturn: []),
                                   rowHeight: subject.rowHeight.asDriver(onErrorJustReturn: []))
}
