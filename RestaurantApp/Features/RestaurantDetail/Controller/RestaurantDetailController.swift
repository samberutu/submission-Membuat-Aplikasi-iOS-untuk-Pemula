//
//  RestaurantDetailController.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 23/06/21.
//

import UIKit

class RestaurantDetailController: UIViewController {
    
    @IBOutlet weak var menusMainView: UIView!
    @IBOutlet weak var heightOfMenusMainView: NSLayoutConstraint!
    @IBOutlet weak var menusTable: UITableView!
    //main property
    @IBOutlet weak var restorantImage: UIImageView!
    @IBOutlet weak var restorantAddress: UILabel!
    @IBOutlet weak var restorantName: UILabel!
    @IBOutlet weak var restorantRating: UILabel!
    @IBOutlet weak var restorantDesc: UILabel!
    @IBOutlet weak var restaurantCategory: UILabel!
    @IBOutlet weak var reviewersTable: UITableView!
    @IBOutlet weak var heightOfReviewerMainView: NSLayoutConstraint!
    @IBOutlet weak var reviewerMainView: UIView!
    @IBOutlet weak var descTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var readMoreBtn: UIButton!
    @IBOutlet weak var descMainView : UIView!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var offlineImg: UIImageView!
    @IBOutlet weak var offlineLbl: UILabel!
    @IBOutlet weak var locationSimbol: UIImageView!
    @IBOutlet weak var ratingSimbol: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    
    
    //another property
    private var dataSource : DetailResponse?
    private var restorantDetail : [Restaurant]?
    private var menusTableModel : [Menus]?
    private var reviewer : [CustomerReviews]?
    private var menusCount = 0
    private var foodsMenu = 0
    private var drinksMenu = 0
    private var reviewersCount = 0
    private var maxHeightOfText : CGFloat = 150
    private var isAbble = false
    private var isClicked = false
    private var isFavorited = false
    var didConnect = false
    var didOffline = false
    let reachability = try! Reachability()
    var getRestaurantId = ""
    private var numberOfRowSection : [Int] = []
    private var valueOfRowSection : [[Name]] = []
    private var menusSection : [String] = ["Drinks","Foods"]
    
    //coreData
    var seederCoreDataStore = SeederCoreDataStore()
    var restorantIdForCore = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        checkRestaurantFavorite()
        setUpMenusTable()
        setUpReviewerTable()
        setUpNetwork()
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        
        if isFavorited == false {
            isFavorited = true
            seederCoreDataStore.add(restaurant: dataSource!.restaurant)
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteBtn.tintColor = .red
            favoriteBtn.contentMode = .scaleAspectFill
            Toast.show(message: "Favorite", controller: self)
        }else{
            seederCoreDataStore.delete(restorantIdForCore)
            isFavorited = false
            favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteBtn.tintColor = .black
            favoriteBtn.contentMode = .scaleAspectFill
            Toast.show(message: "Dihapus", controller: self)
        }
    }
    
    @IBAction func readMoreButton(_ sender: UIButton) {
        let height = DinamicLabelSize.getMaxHeight(text: restorantDesc.text, width: view.frame.width)
        
        if isClicked == false{
            descTextHeightConstraint.constant = height + 70
            descMainView.layoutIfNeeded()
            readMoreBtn.setTitle("Lebih sedikit", for: .normal)
            isClicked = true
        }else{
            descTextHeightConstraint.constant = 100
            descMainView.layoutIfNeeded()
            readMoreBtn.setTitle("Selengkapnya", for: .normal)
            isClicked = false
        }
    }
    
    func setupScrollView (){
        if #available(iOS 11.0, *) {
            scroll.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
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
    
    func checkRestaurantFavorite(){
        
        if seederCoreDataStore.checkId(getRestaurantId) == true {
            
            isFavorited = true
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteBtn.tintColor = .red
            favoriteBtn.contentMode = .scaleAspectFill
            
        }else{
            
            isFavorited = false
            favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteBtn.tintColor = .black
            favoriteBtn.contentMode = .scaleAspectFill
            
        }
    }
    
    private func setUpURL() -> String {
        restorantIdForCore = getRestaurantId
        getRestaurantId = Constant.restorantDetail + getRestaurantId
        return getRestaurantId
    }
    
    private func reloadTable(_ detailResponse : DetailResponse){
        dataSource = detailResponse
        DispatchQueue.main.async {
            self.updateProperty()
            self.menusTable.reloadData()
            self.reviewersTable.reloadData()
        }
    }
    
    
    private func setUpReviewerTable(){
        reviewersTable.dataSource = self
        reviewersTable.register(CustomerReviewsCell.nib(), forCellReuseIdentifier: "customerReviewsCell")
        reviewersTable.alwaysBounceVertical = true
        reviewersTable.allowsSelection = false
        reviewersTable.separatorStyle = .none
        reviewersTable.showsHorizontalScrollIndicator = false
        reviewersTable.showsVerticalScrollIndicator = false
    }
    
    private func setRestaurantCategory(_ name: [Name]){
        var category = ""
        for i in name{
            category += i.name + " . "
        }
        let currentCategory = category.dropLast(2)
        restaurantCategory.text = String(currentCategory)
    }
    
    private func setUpMenusTable(){
        menusTable.dataSource = self
        menusTable.register(MenusCell.nib(), forCellReuseIdentifier: "menusCell")
        menusTable.alwaysBounceVertical = true
        menusTable.allowsSelection = false
        menusTable.separatorStyle = .none
        menusTable.showsHorizontalScrollIndicator = false
        menusTable.showsVerticalScrollIndicator = false
    }
    
    private func updateProperty(){
        restorantImage.downloaded(from: Constant.largeImageUrl + dataSource!.restaurant.pictureID)
        restorantImage.contentMode = UIView.ContentMode.scaleAspectFill
        restorantName.text = dataSource?.restaurant.name
        restorantAddress.text = "\(dataSource?.restaurant.city ?? ""), \(dataSource?.restaurant.address ?? "")"
        restorantDesc.text = dataSource?.restaurant.restaurantDescription
        restorantRating.text = "\(dataSource?.restaurant.rating ?? 0 )/5 (\(dataSource?.restaurant.customerReviews.count ?? 0) Reviewers)"
        setRestaurantCategory((dataSource?.restaurant.categories)!)
        
        //tableview property
        drinksMenu = dataSource!.restaurant.menus.drinks.count
        foodsMenu = dataSource!.restaurant.menus.foods.count
        reviewer = dataSource!.restaurant.customerReviews
        menusCount = drinksMenu + foodsMenu
        reviewersCount = dataSource!.restaurant.customerReviews.count
        numberOfRowSection.append(drinksMenu)
        numberOfRowSection.append(foodsMenu)
        valueOfRowSection.append(dataSource!.restaurant.menus.drinks)
        valueOfRowSection.append(dataSource!.restaurant.menus.foods)
        
        //change height tableview
        setUpHeightOfViewProperty(menusCount)
        setUpHeightOfReviewProperty(reviewersCount)
        
        //description checked
        checkDesc()
        
    }
    
    private func checkDesc(){
        if restorantDesc.isTruncated {
            readMoreBtn.isHidden = false
        }else{
            readMoreBtn.isHidden = true
        }
    }
    
    private func setUpHeightOfViewProperty(_ countOfCell : Int){
        var cellHeight = countOfCell + 2
        cellHeight *= 44
        heightOfMenusMainView.constant = CGFloat(cellHeight) + 24
        menusMainView.layoutIfNeeded()
        
        
    }
    
    private func setUpHeightOfReviewProperty(_ height : Int){
        let currentHeight = height * 130
        heightOfReviewerMainView.constant = CGFloat(currentHeight) + 50
        reviewerMainView.layoutIfNeeded()
        isAbble = true
    }
    
    
    
}

extension RestaurantDetailController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == menusTable{
            if valueOfRowSection.isEmpty{
                return 0
            }else{
                return valueOfRowSection.count
            }
        }else{
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menusTable  {
            if valueOfRowSection.isEmpty{
                return 0
            }else{
                return valueOfRowSection[section].count
            }
        }else{
            if isAbble == false{
                return 0
            }else{
                return reviewer?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == menusTable{
            let cell = menusTable.dequeueReusableCell(withIdentifier: "menusCell", for: indexPath) as! MenusCell
            if valueOfRowSection.isEmpty{
                return cell
            }else{
                
                cell.menusTitle.text = valueOfRowSection[indexPath.section][indexPath.row].name
                
                return cell
            }
        }else{
            let cell = reviewersTable.dequeueReusableCell(withIdentifier: "customerReviewsCell", for: indexPath) as! CustomerReviewsCell
            cell.customerName.text = reviewer![indexPath.row].name
            cell.reviewDate.text = reviewer![indexPath.row].date
            cell.reviewerText.text = reviewer![indexPath.row].review
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == menusTable {
            if valueOfRowSection.isEmpty{
                return ""
            }else{
                return menusSection[section]
            }
        }
        
        return ""
    }
    
    
}

extension RestaurantDetailController{
    
    func fetchData(completionHandler : @escaping(DetailResponse) -> Void) {
        
        let url = URL(string:setUpURL())!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data =  data else {return}
            
            do{
                let postData = try! JSONDecoder().decode(DetailResponse.self, from : data)
                
                completionHandler(postData)
                
            }
        }.resume()
    }
    
    func offline(){
        didOffline = true
        offlineImg.isHidden = false
        offlineLbl.isHidden = false
        restorantImage.isHidden = true
        restorantAddress.isHidden = true
        restorantName.isHidden = true
        restorantRating.isHidden = true
        restorantDesc.isHidden = true
        restaurantCategory.isHidden = true
        reviewersTable.isHidden = true
        reviewerMainView.isHidden = true
        readMoreBtn.isHidden = true
        descMainView.isHidden = true
        favoriteBtn.isHidden = true
        menusMainView.isHidden = true
        menusTable.isHidden = true
        locationSimbol.isHidden = true
        ratingSimbol.isHidden = true
    }
    
    func online(){
        loadingView.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (t) in
            self.loadingView.stopAnimating()
        }
        
        if didConnect == false && didOffline == false{
            fetchData{ (posts) in
                self.didConnect = true
                self.reloadTable(posts)
            }
            offlineImg.isHidden = true
            offlineLbl.isHidden = true
        }else{
            offline()
        }
        
    }
    
    
    
}


extension UILabel {
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}


