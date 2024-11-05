//
//  BannerViewModel.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/13/23.
//

import Foundation
import RxSwift
import RxRelay

struct BannerCellModel {
    var imagePath: String
    var identifier: String
    var description: String
}

protocol BannerViewModelType {
    var imagePath: BehaviorRelay<String?> { get set }
    var description: BehaviorRelay<String?> { get set }
    var identifier: BehaviorRelay<String?> { get set }
}

class BannerViewModel: BannerViewModelType {
    private var model: BannerCellModel
    
    var imagePath: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    var identifier: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    var description: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    
    required init(model: BannerCellModel) {
        self.model = model
        
        imagePath.accept(model.imagePath)
        identifier.accept(model.identifier)
        description.accept(model.description)
    }
}

