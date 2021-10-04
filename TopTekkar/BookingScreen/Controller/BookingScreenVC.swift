//
//  BookingScreenVC.swift
//  TopTekkar
//
//  Created by Murugesh on 19/09/21.
//

import UIKit
import ADDatePicker
class BookingScreenVC: UIViewController {

    @IBOutlet weak var bookingTableview: UITableView!
    @IBOutlet weak var turfCollectionView: UICollectionView!

    @IBOutlet weak var sportsListCollectionView: UICollectionView!
    @IBOutlet weak var timeSlotCollectionView: UICollectionView!
    @IBOutlet weak var datePicker: ADDatePicker!

    var bookingViewModel = BookingViewModel()
    var servicesData : [BookingModelData]?
    var acadamySportsDetails : [SportsDetails]?
    var selectedCategory:SearchCategoriesDataModel?

    var timeSlot : TimeSlotSection?
    var timeslotDeatilArray  : [TimeSlotDetailArray]?

    override func viewDidLoad() {
        super.viewDidLoad()
        timeslotDeatilArray = [TimeSlotDetailArray]()
//        self.sportsListCollectionView.register(SportsListCollectionViewCell.self, forCellWithReuseIdentifier: "SportsListCollectionViewCell")
   
        customDatePicker1()
        self.timeSlotCollectionView.contentInsetAdjustmentBehavior = .never
        self.timeSlotCollectionView.collectionViewLayout = getCollectionLayout()
        self.sportsListCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        
        
        if let data = defaults.object(forKey: "selectedCategory") as? Data {
            let decoder = JSONDecoder()
            if let selectedCategory = try? decoder.decode(SearchCategoriesDataModel.self, from: data) {
                self.selectedCategory = selectedCategory
            }
        }

    
        if let categoryId = self.selectedCategory?.id {
            self.bookingViewModel.getServicesRequest(categoryId: categoryId, busId: "10")
        }
     
        self.bookingViewModel.bindingData = {
            if let data = self.bookingViewModel.servicesData{
                self.servicesData = self.bookingViewModel.servicesData
                DispatchQueue.main.async {
                self.turfCollectionView.reloadData()
                }
                if let turfId = self.servicesData?[0].id, let categoryID = self.selectedCategory?.id, let busID = self.servicesData?[0].busID{
                    self.timeSlotRequest(date: self.getCurrentDate(), turfId: turfId, category: categoryID, busID: busID, userTypeId: "2", timeSlotType: "normal", planId: "1", catId: categoryID, userId: "95")

                }
            }
        }
      
    

        
      
        self.bookingViewModel.timeSlotBindingData = {
            if let data = self.bookingViewModel.timeSlot{
                self.timeSlot = data
                
                if let morning =  self.timeSlot?.morning , let afternoon = self.timeSlot?.afternoon ,let evening = self.timeSlot?.evening{
                    self.timeslotDeatilArray?.append(contentsOf: morning)
                    self.timeslotDeatilArray?.append(contentsOf: afternoon)
                    self.timeslotDeatilArray?.append(contentsOf: evening)
                }
                
                DispatchQueue.main.async {
                self.timeSlotCollectionView.reloadData()
                }

            }
        }
    }

    func timeSlotRequest(date:String,turfId:String,category:String,busID:String,userTypeId:String,timeSlotType:String,planId:String,catId:String,userId:String){
        let data =  TimeSlotRequestData(date: date, turf_id: turfId, category: category, bus_id: busID, user_type_id: userTypeId, type: timeSlotType, plan_id: planId, cat_id: catId, user_id: userId)
        self.bookingViewModel.getTimeSlotDetails(timeSlotRequestData: data)
    }

     func getCurrentDate() -> String {

           let dateFormatter = DateFormatter()

           dateFormatter.dateFormat = "yyy-MM-dd"

           return dateFormatter.string(from: Date())

       }

    
    func customDatePicker1(){

        datePicker.yearRange(inBetween: 1990, end: 2022)
        datePicker.selectionType = .circle
        datePicker.bgColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        datePicker.deselectTextColor = UIColor.init(white: 1.0, alpha: 0.7)
        datePicker.deselectedBgColor = .clear
        datePicker.selectedBgColor = .white
        datePicker.selectedTextColor = .yellow
        datePicker.intialDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        datePicker.delegate = self
    }
    
    
    func timeslotBtnAction(indexPath:IndexPath)  {
        <#function body#>
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BookingScreenVC: ADDatePickerDelegate {
    func ADDatePicker(didChange date: Date) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        if let turfId = self.servicesData?[0].id, let busID = self.servicesData?[0].busID{
            self.timeSlotRequest(date: dateformatter.string(from: date), turfId: turfId, category: "10", busID: busID, userTypeId: "2", timeSlotType: "normal", planId: "1", catId: "10", userId: "95")

        }
    }
}


extension BookingScreenVC : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func getCollectionLayout() -> UICollectionViewFlowLayout{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
              layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3)-10, height: 30)
              layout.minimumInteritemSpacing = 3
              layout.minimumLineSpacing = 3
        return layout
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sportsListCollectionView {
            return acadamySportsDetails?.count ?? 0
        }else if collectionView == turfCollectionView{
            return servicesData?.count ?? 0
        }else{
            return self.timeslotDeatilArray?.count ?? 0
        }

    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sportsListCollectionView {

            print("sports")
        }
        else if collectionView == turfCollectionView{
            print("turf")

        }else{
            print("timeslot")
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == sportsListCollectionView {
            let cell = self.sportsListCollectionView.dequeueReusableCell(withReuseIdentifier: "SportsListCollectionViewCell", for: indexPath) as? SportsListCollectionViewCell
            if let imageName = self.acadamySportsDetails?[indexPath.row].image {
                let url = TTAppConstant.UrlConstant.baseUrl+TTAppConstant.UrlConstant.categoryAPI+imageName
                self.bookingViewModel.downloadImage(url: url) { (response) in
                    if let data = response as? Data{
                        cell?.titleImageView.image =  UIImage.init(data: data)
                    }
                }
                cell?.titleName.text = self.acadamySportsDetails?[indexPath.row].title
                return cell ?? UICollectionViewCell()
            }
        }
        else if collectionView == turfCollectionView{
            let cell = self.turfCollectionView.dequeueReusableCell(withReuseIdentifier: "TurfCell", for: indexPath) as? BookingTurfCollectionViewCell
            cell?.playingArea.setTitle(self.servicesData?[indexPath.row].serviceTitle, for: UIControl.State.normal)
            return cell ?? UICollectionViewCell()
        }
        else{
            let cell = self.timeSlotCollectionView.dequeueReusableCell(withReuseIdentifier: "TimeSlotCell", for: indexPath) as? TimeSlotCollectionViewCell
            
            cell?.timeSlotLbl.setTitle(self.timeslotDeatilArray?[indexPath.row].slotLabel, for: UIControl.State.normal)
            cell?.priceLbl?.text = self.timeslotDeatilArray?[indexPath.row].price

            return cell ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
        
    }
}

extension BookingScreenVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.bookingTableview.dequeueReusableCell(withIdentifier: "BookingTableViewCell", for: indexPath) as? BookingTableViewCell
        else { return  UITableViewCell() }
        
        if indexPath.row == 1 {
//            self.turfCollectionView.isScrollEnabled = true
            DispatchQueue.main.async {
            self.turfCollectionView.reloadData()
            }
        }
        
        return cell
    }
    
    
}
