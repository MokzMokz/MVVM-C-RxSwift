//
//  CustomFlowLayout.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/27/23.
//

import UIKit

struct Constants {
  static let row = 3.0
  
  static func calculateheight(row: Float) -> CGFloat {
    switch row {
    case 3:
      return 270.0
    case 4:
      return 200.0
    default:
      return 0
    }
  }
}

class CustomFlowLayout: UICollectionViewFlowLayout {
  
  override func prepare() {
    super.prepare()
    
    // Set the scroll direction to horizontal
    scrollDirection = .vertical
    
    // Adjust the section inset to add spacing at the beginning and end
    sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    let estimateSize = (ScreenSize.screenWidth / Constants.row) - (5 * Constants.row)
    itemSize = CGSize(width: estimateSize, height: estimateSize)
    // Adjust the minimum spacing between items horizontally
    minimumInteritemSpacing = 10
  }
}
