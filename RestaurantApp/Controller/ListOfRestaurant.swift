//
//  ViewController.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 23/06/21.
//

import UIKit
import Network

class ListOfRestaurant: UIViewController {
    
    //another property for restorant
    private var getListOfRestaurant = GetListOfResaurants()
    private var dataSource : Response?
    private var restorantData : [RestaurantModel]?
    var restaurantId = ""
    var didConnect = false
    var didOffline = false
    private var imgFromUrl:UIImageView?
    let reachability = try! Reachability()
    
    @IBOutlet weak var restorantTable: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var offlineImg: UIImageView!
    @IBOutlet weak var offlineLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNetwork()
    }
    
    func setUpNetwork(){
        self.reachability.whenReachable = { reachability in
            self.online()
        }
        self.reachability.whenUnreachable = { _ in
            self.offline()
        }
        
        do {
            try self.reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    deinit {
        self.reachability.stopNotifier()
    }
    
    func offline(){
        didOffline = true
        offlineImg.isHidden = false
        offlineLbl.isHidden = false
        restorantTable.isHidden = true
    }
    
    func online(){
        loadingView.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (t) in
            self.loadingView.stopAnimating()
        }
        
        if didConnect == false && didOffline == false{
            subscribeGetAPI()
            restorantTable.isHidden = false
            restorantTable.reloadData()
            offlineImg.isHidden = true
            offlineLbl.isHidden = true
        }else{
            offline()
        }
        
    }
    
    func setUpTableView(){
        restorantTable.dataSource = self
        restorantTable.delegate = self
        restorantTable.register(RestaurantCell.nib(), forCellReuseIdentifier: "restaurantCell")
        restorantTable.separatorStyle = .none
        restorantTable.showsHorizontalScrollIndicator = false
        restorantTable.showsVerticalScrollIndicator = false
    }
    
    private func subscribeGetAPI(){
        didConnect = true
        getListOfRestaurant.bindRestaurantViewController = {
            self.bindData()
        }
    }
    
    private func bindData(){
        dataSource = getListOfRestaurant.dataFromAPI
        restorantData = dataSource?.restaurants
        DispatchQueue.main.async {
            self.restorantTable.reloadData()
        }
    }
    
    
}

extension ListOfRestaurant : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restorantData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        let img : String = (dataSource?.restaurants[indexPath.row].pictureId)!
        cell.restorantImage.layer.cornerRadius = cell.restorantImage.frame.size.width/2
        cell.restorantName.text = dataSource?.restaurants[indexPath.row].name
        cell.restorantRating.text = "\(dataSource?.restaurants[indexPath.row].rating ?? 0.0)"
        cell.restorantDescription.text = dataSource?.restaurants[indexPath.row].description
        cell.restorantImage.downloaded(from: Constant.smallImageUrl + img)
        cell.restorantImage.contentMode = UIView.ContentMode.scaleAspectFill
        cell.restaurantId = dataSource?.restaurants[indexPath.row].id
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "RestaurantDetail") as? RestaurantDetailController
        vc?.getRestaurantId = dataSource!.restaurants[indexPath.row].id 
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
