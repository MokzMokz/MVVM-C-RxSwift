//
//  ViewController+Extensions.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/21/23.
//

import UIKit

extension UIViewController {
    func removeBackButtonTitle() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
