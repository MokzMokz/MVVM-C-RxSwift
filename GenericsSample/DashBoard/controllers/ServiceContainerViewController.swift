//
//  ServiceContainerViewController.swift
//  GenericsSample
//
//  Created by COLLABERA on 10/5/23.
//

import UIKit

class ServiceContainerViewController: UIViewController {
  
  var viewModel: ServiceItemViewModelType!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    // Do any additional setup after loading the view.
  }
  
  private func setupView() {
    removeBackButtonTitle()
    self.title = viewModel.name.value
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
