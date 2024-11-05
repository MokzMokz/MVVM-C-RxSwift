//
//  BannerViewController.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/21/23.
//

import UIKit

class BannerContainerViewController: UIViewController {
    var viewModel: BannerViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        removeBackButtonTitle()
        self.title = viewModel.description.value
    }

}
