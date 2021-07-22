//
//  MenusCell.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 02/07/21.
//

import UIKit

class MenusCell: UITableViewCell {
    

    @IBOutlet weak var menusTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib()->UINib{
        return UINib(nibName: "MenusCell", bundle: nil)
    }
    
}
