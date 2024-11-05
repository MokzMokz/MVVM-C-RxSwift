//
//  ServicesTableViewCell.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/27/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ServicesTableViewCell: UITableViewCell,
                             BindableType,
                             DashboardBindableType, UIScrollViewDelegate {
  
  var viewModel: ServiceViewModelType!
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var collectionView: UICollectionView!
  private var dataSource: RxCollectionViewSectionedReloadDataSource<DashboardSectionModel>!
  
  private func setupView() {
    let layout = CustomFlowLayout()
    collectionView.collectionViewLayout = layout
    collectionView.backgroundColor = .green
    collectionView.dataSource = nil
    collectionView.delegate = nil

    dataSource = RxCollectionViewSectionedReloadDataSource<DashboardSectionModel> {
      (_, collectionView, indexPath, item) in

      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath)
      if let cell = cell as? DashboardBindableType {
        cell.bindItemModel(to: item)
      }
      return cell
    }
    
    collectionView.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        
        guard let self = self else { return }
        
        self.viewModel.navigateToService(at: indexPath)
      })
      .disposed(by: disposeBag)
    
    viewModel.services
      .map { [DashboardSectionModel(items: $0)] } // Map your data to the expected structure
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
  
  func bindViewModel() {
    setupView()
  }
}
