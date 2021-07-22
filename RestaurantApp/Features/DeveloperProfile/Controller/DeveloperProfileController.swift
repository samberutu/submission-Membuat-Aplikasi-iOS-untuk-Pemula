//
//  DeveloperProfileController.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 23/06/21.
//

import UIKit

class DeveloperProfileController: UIViewController {

    
    @IBOutlet weak var mainViewBiodata: UIView!
    @IBOutlet weak var creditBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProperty()

    }
    
    @IBAction func creditButton(_ sender: UIButton) {
        print("pindahh")
        
    }
    
    func setUpProperty(){
        mainViewBiodata.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 30)
        creditBtn.layer.cornerRadius = 10
        profileImg.layer.borderColor = UIColor.restorantAppBlackColor.cgColor
        profileImg.layer.borderWidth = 5

    }
    
    

}

extension UIView {
    func roundCorners(corners:CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
}
