//
//  VenueVC.swift
//  TopTekkar
//
//  Created by Murugesh on 11/09/21.
//

import UIKit

class AcademyListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var acadamyListModel: AcadamyListModel!
    var acadamyListViewModel = AcadamyListViewModel()
    var acadamyListData:[AcadamyDetails]?
    @IBOutlet weak var venueTableView: UITableView!
    
    @IBOutlet weak var venueSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.acadamyListViewModel =  AcadamyListViewModel()
        let populatedDictionary = ["category": "10", "type": "venue"]
        self.acadamyListViewModel.callVenueDataService(reqParam: populatedDictionary)
        self.acadamyListViewModel.bindingData = {
            if self.acadamyListViewModel.AcadamyData != nil{
                self.acadamyListData = self.acadamyListViewModel.AcadamyData
                self.venueTableView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.acadamyListData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?)!
        let bus_logo:UIImageView = cell.viewWithTag(1) as! UIImageView
        let bus_Title:UILabel = cell.viewWithTag(2) as! UILabel
        let bus_GoogleStreet:UILabel = cell.viewWithTag(3) as! UILabel
        
        if let imageName = self.acadamyListData?[indexPath.row].busLogo {
           // let url = TTAppConstant.UrlConstant.baseUrl+TTAppConstant.UrlConstant.Academy_photos_path+imageName
            let url = "http://www.toptekker.com/turfdemo/uploads/admin/category/cricket_(1).png"
            self.acadamyListViewModel.downloadImage(url: url) { (response) in
                if let data = response as? Data{
                    bus_logo.image = UIImage(data: data)
                }
            }
        }

        bus_Title.text = self.acadamyListData![indexPath.row].busTitle
        bus_GoogleStreet.text = self.acadamyListData![indexPath.row].busGoogleStreet

        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AcadamyDetails", sender: self)

    }
    
    /*
     /Users/murugesh/Desktop/TopTekkar/TopTekkar/VenueScreen    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
