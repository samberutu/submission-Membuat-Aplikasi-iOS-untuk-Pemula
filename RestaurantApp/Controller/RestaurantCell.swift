//
//  RestaurantCell.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 23/06/21.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restorantImage: UIImageView!
    @IBOutlet weak var restorantName: UILabel!
    @IBOutlet weak var restorantRating: UILabel!
    @IBOutlet weak var restorantDescription: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var mainBg: UIView!
    @IBOutlet weak var superView: UIView!
    var restaurantId : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpAnotherProperty()
        setUpColorsAndAnotherProperty()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpAnotherProperty(){
        
        mainBg.layer.cornerRadius = 15
    }
    
    static func nib()->UINib{
        return UINib(nibName: "RestaurantCell", bundle: nil)
    }
    
    func setUpColorsAndAnotherProperty(){
        ratingImage.tintColor = .orange
        mainBg.backgroundColor = .white
        mainBg.layer.borderWidth = 1
        mainBg.layer.borderColor = UIColor.restorantAppBlackColor.cgColor
        
    }
    
}

