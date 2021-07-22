//
//  CustomerReviewsCell.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 05/07/21.
//

import UIKit

class CustomerReviewsCell: UITableViewCell {

    @IBOutlet weak var mainViewcustomerCell: UIView!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var reviewerText: UILabel!
    @IBOutlet weak var reviewerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reviewerImage.layer.cornerRadius = reviewerImage.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib()->UINib{
        return UINib(nibName: "CustomerReviewsCell", bundle: nil)
    }
    
}
