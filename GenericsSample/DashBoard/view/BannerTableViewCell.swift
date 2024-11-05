//
//  BannerTableViewCell.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/12/23.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class BannerTableViewCell: UITableViewCell,
                           BindableType,
                           DashboardBindableType {

    @IBOutlet weak var imageBanner: UIImageView!
  
    var viewModel: BannerViewModelType!
    @IBOutlet weak var descriptionLabel: UILabel!
    private let disposeBag = DisposeBag()
    
    func bindViewModel() {
        viewModel
            .description
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .imagePath
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] urlString in
                
                guard let self = self,
                      let url = URL(string: urlString ?? "") else { return }
                
                self.imageBanner.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
        
    }
}
