//
//  BookingViewModel.swift
//  TopTekkar
//
//  Created by Murugesh on 19/09/21.
//

import UIKit
import Alamofire
class BookingViewModel: NSObject {
    
    var timeSlot : TimeSlotSection!{
        didSet{
            self.timeSlotBindingData()
        }
    }
    var servicesData : [BookingModelData]! {
        didSet{
            self.bindingData()
        }
    }
    
    

    var bindingData :(() -> ()) = {}
    var timeSlotBindingData :(() -> ()) = {}

    func getTimeSlotDetails(timeSlotRequestData:TimeSlotRequestData){
        let dict = ["date":timeSlotRequestData.date,
                    "turf_id":timeSlotRequestData.turf_id,
                    "category":"10",
                    "bus_id":timeSlotRequestData.bus_id,
                    "user_type_id":timeSlotRequestData.user_type_id,
                    "type":timeSlotRequestData.type,
                    "plan_id":timeSlotRequestData.plan_id,
                    "cat_id":"10","user_id":timeSlotRequestData.user_id];
        
        APIHandler.shared.sendRequestAlomofire(url: "http://www.toptekker.com/turfdemo/index.php/api/get_time_slot", parameters: dict, encoding: URLEncoding.httpBody, decoder: TimeSlot.self) { (response, error) in
            if let response = response as? TimeSlot{
                print(response)
                self.timeSlot = response.data
            }else{
                print(error as Any)
            }
        }
    }
    
    func getServicesRequest(categoryId:String,busId:String) {
        let dict = ["cat_id":categoryId,"bus_id":busId];
        APIHandler.shared.sendRequestAlomofire(url: "http://www.toptekker.com/turfdemo/index.php/api/get_services", parameters: dict, encoding: URLEncoding.httpBody, decoder: BookingModel.self) { (response, error) in
            if let response = response as? BookingModel{
                print(response)
                self.servicesData = response.data
            }else{
                print(error as Any)
            }
        }
    }
    
    
    func downloadImage(url:String, completion: @escaping (Any) -> Void) {
        APIHandler.shared.downloadRequest(url: url) { (response, error) in
            
            guard error == nil else{
                return
            }
            completion(response)
        }
    }
    

}
