//
//  CreditPageCell.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 16/07/21.
//

import UIKit

class CreditPageCell: UITableViewCell {

    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var linkLbl : UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib()->UINib{
        return UINib(nibName: "CreditPageCell", bundle: nil)
    }
    
}
