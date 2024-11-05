//
//  ServiceCollectionViewCell.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/27/23.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ServiceCollectionViewCell: UICollectionViewCell,
                                 BindableType,
                                 DashboardBindableType {
  
  @IBOutlet weak var imageView: UIImageView!
  
  var viewModel: ServiceItemViewModelType!
  private let disposeBag = DisposeBag()
  
  func bindViewModel() {
    viewModel
      .imagePath
      .observe(on: MainScheduler.instance)
      .bind(onNext: { [weak self] urlString in
        
        guard let self = self,
              let url = URL(string: urlString ?? "") else { return }
        
        self.imageView.kf.setImage(with: url)
      })
      .disposed(by: disposeBag)
  }
  
    
}
