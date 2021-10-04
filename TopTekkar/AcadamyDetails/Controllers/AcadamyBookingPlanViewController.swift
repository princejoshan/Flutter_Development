//
//  AcadamyBookingPlanViewController.swift
//  TopTekkar
//
//  Created by Prince  on 21/09/21.
//

import UIKit

class AcadamyBookingPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var continueWithnormalbooking: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var acadamyDetailViewModel : AcadamyDetailViewModel!
    var acadamyBookingPlanDetails : AcadamyBookingPlanModel?

    @IBOutlet weak var bookingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.specialTimingApiRequest()
    }
    
    func setUpUI()  {
        self.continueWithnormalbooking.setTitleColor(UIColor.white, for: .normal)
        self.continueWithnormalbooking.backgroundColor = UIColor.MyApp.colorPrimary
        self.continueWithnormalbooking.cornerRadius()
        self.continueWithnormalbooking.setTitle("Continue with normal booking", for: .normal)
        bookingTableView.reloadData()
    }
    
    func specialTimingApiRequest() {
        self.acadamyDetailViewModel =  AcadamyDetailViewModel()
        let populatedDictionary = ["bus_id": "10","user_id":"95","user_type":"user","category":"10"]
        self.acadamyDetailViewModel.callSpecialTimingService(reqParam: populatedDictionary)
        self.acadamyDetailViewModel.bindingBookingPlanDetails = {
            if self.acadamyDetailViewModel.BookingPlanDetails != nil{
                self.acadamyBookingPlanDetails = self.acadamyDetailViewModel.BookingPlanDetails
                self.bookingTableView.reloadData()
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return  self.acadamyBookingPlanDetails?.data.count ?? 0;
        }
        return self.acadamyBookingPlanDetails?.specialTimings.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell
        if indexPath.section == 0 {
            cell = (tableView.dequeueReusableCell(withIdentifier: "cell1") as UITableViewCell?)!
            let backgroundView:UIView = cell.viewWithTag(1)!
            backgroundView.cornerRadius()
            let name:UILabel = cell.viewWithTag(2) as! UILabel
            let category:UILabel = cell.viewWithTag(4) as! UILabel
            let hoursRemaining:UILabel = cell.viewWithTag(5) as! UILabel
            name.text = self.acadamyBookingPlanDetails?.data[indexPath.row].name
            category.text = self.acadamyBookingPlanDetails?.data[indexPath.row].categoryName
            hoursRemaining.text = "Hours Remaining :\(self.acadamyBookingPlanDetails!.data[indexPath.row].noOfHours)"


        }
        else {
            cell = (tableView.dequeueReusableCell(withIdentifier: "cell2") as UITableViewCell?)!
             let backgroundView:UIView = cell.viewWithTag(1)!
             backgroundView.cornerRadius()
             backgroundView.backgroundColor = UIColor.MyApp.colorPrimary
             let title:UILabel = cell.viewWithTag(2) as! UILabel
             let categorytitle:UILabel = cell.viewWithTag(3) as! UILabel
             let timing:UILabel = cell.viewWithTag(4) as! UILabel
             let workingDays:UILabel = cell.viewWithTag(5) as! UILabel
            categorytitle.text = self.acadamyBookingPlanDetails?.specialTimings[indexPath.row].categoriesTitle
            timing.text = "\(self.acadamyBookingPlanDetails!.specialTimings[indexPath.row].morningTimeStart), \(self.acadamyBookingPlanDetails!.specialTimings[indexPath.row].morningTimeEnd),\(self.acadamyBookingPlanDetails!.specialTimings[indexPath.row].afternoonTimeStart), \(self.acadamyBookingPlanDetails!.specialTimings[indexPath.row].afternoonTimeEnd),\(self.acadamyBookingPlanDetails!.specialTimings[indexPath.row].eveningTimeStart), \(self.acadamyBookingPlanDetails!.specialTimings[indexPath.row].eveningTimeEnd)"
             title.text = self.acadamyBookingPlanDetails?.specialTimings[indexPath.row].title
             workingDays.text = self.acadamyBookingPlanDetails?.specialTimings[indexPath.row].workingDays

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "headercell") as UITableViewCell?)!
        let heading:UILabel = cell.viewWithTag(1) as! UILabel
        switch section{
        case 0:
            heading.text = "Choose your plan"
        case 1:
            heading.text = "Special Timings"
        default:
            heading.text = "Default Will Be Left"
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
      }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    @IBAction func normalBookingAction(_ sender: UIButton) {
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        performSegue(withIdentifier: "paymentDetails", sender: self)

        
    }
}


//
//extension AcadamyBookingPlanViewController:UITableViewDelegate,UITableViewDataSource {
//    
//    
//}
