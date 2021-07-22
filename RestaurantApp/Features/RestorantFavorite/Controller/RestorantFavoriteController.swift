//
//  RestorantFavoriteController.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 23/06/21.
//

import UIKit

class RestorantFavoriteController: UIViewController {
    //another property for restorant
    private var restaurant : [RestaurantCore]?
    
    @IBOutlet weak var favoriteRestaurantTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        checkCoreData()
        setUpTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        checkCoreData()
    }
    
    func checkCoreData(){
        let seederCoreDataStore = SeederCoreDataStore().getRestorantCore()
        restaurant = seederCoreDataStore
        favoriteRestaurantTable.reloadData()
    }
    
    func setUpTableView(){
        favoriteRestaurantTable.dataSource = self
        favoriteRestaurantTable.delegate = self
        favoriteRestaurantTable.register(RestaurantCell.nib(), forCellReuseIdentifier: "restaurantCell")
        favoriteRestaurantTable.separatorStyle = .none
        favoriteRestaurantTable.showsHorizontalScrollIndicator = false
        favoriteRestaurantTable.showsVerticalScrollIndicator = false
    }


}

extension RestorantFavoriteController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        let pictureId : String = (restaurant![indexPath.row].pictureId)!
        
        cell.restorantName.text = restaurant?[indexPath.row].name
        cell.restorantDescription.text = restaurant?[indexPath.row].desc
        cell.restorantRating.text = "\(restaurant?[indexPath.row].rating ?? 0)"
        cell.restorantImage.downloaded(from: Constant.largeImageUrl + pictureId)
        cell.restorantImage.contentMode = UIView.ContentMode.scaleAspectFill
        cell.restorantImage.layer.cornerRadius = cell.restorantImage.frame.size.width/2
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "RestaurantDetail") as? RestaurantDetailController
        vc?.getRestaurantId = restaurant![indexPath.row].id!
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

