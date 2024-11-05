//
//  CellConfigurable.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/13/23.
//

import Foundation
import UIKit

protocol CellConfigurable {
    var cellTypeIdentifier: String { get }
    func configureCell(_ cell: UITableViewCell)
}
