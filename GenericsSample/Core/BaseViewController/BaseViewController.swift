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

protocol BaseViewControllerType: UIViewController {
  
  // MARK: - Setups
  func setupData()
  func setupView()
  func setupObservers()

}


class BaseViewController<VM: BaseViewModel>: UIViewController, BaseViewControllerType {
    var viewModel: VM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Perform common setup for all view controllers here, if needed
        setupView()
        setupObservers()
    }
    
    func setupData() { }
    func setupView() { }
    func setupObservers() { }
}
