//
//  BaseViewController.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/12/23.
//

import UIKit
import RxSwift

protocol ViewModelable where Self: UIViewController {
    
    // MARK: - Associated Types
    
    associatedtype ViewModelType: AnyObject
    
    // MARK: - Properties
    
    var viewModel: ViewModelType? { get set }
    var disposeBag: DisposeBag { get }
}


class BaseViewController<BaseViewModel: ViewModel>: UIViewController {
    
    var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Perform common setup for all view controllers here, if needed
    }
}
