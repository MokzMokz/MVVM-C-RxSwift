//
//  SeparatorTableViewCell.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/13/23.
//

import UIKit

class SeparatorTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //    var viewModel: EmptyCellViewModelType!
    //
    //    func bindViewModel() {
    //
    //    }
        
}
