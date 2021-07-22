//
//  CreditPageController.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 16/07/21.
//

import UIKit

class CreditPageController: UIViewController {

    @IBOutlet weak var creditTable: UITableView!
    var data : [CreditModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpCreditTable()
    }
    
    func setUpData(){
        data.append(CreditModel(title: "Custom Toast", link: "https://stackoverflow.com/questions/31540375/how-to-create-a-toast-message-in-swift/50710991#50710991"))
        data.append(CreditModel(title: "Reachability", link: "https://github.com/ashleymills/Reachability.swift"))
    }
    func setUpCreditTable(){
        creditTable.dataSource = self
        creditTable.register(CreditPageCell.nib(), forCellReuseIdentifier: "creditPageCell")
        creditTable.separatorStyle = .none
        creditTable.showsHorizontalScrollIndicator = false
        creditTable.showsVerticalScrollIndicator = false
    }


}

extension CreditPageController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditPageCell", for: indexPath) as! CreditPageCell
        
        cell.labelTitle.text = data[indexPath.row].title
        cell.linkLbl.text = data[indexPath.row].link
        
        return cell
    }
    
    
}

struct CreditModel {
    let title : String
    let link : String
}
