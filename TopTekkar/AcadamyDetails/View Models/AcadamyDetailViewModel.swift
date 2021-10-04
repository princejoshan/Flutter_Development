//
//  AcadamyDetailViewModel.swift
//  TopTekkar
//
//  Created by Prince  on 20/09/21.
//

import Foundation
import Alamofire

class AcadamyDetailViewModel {
   private(set) var AcadamySportsDetails : [SportsDetails]! {
       didSet {
           self.bindingData()
       }
   }
    
    private(set) var AcadamyPhotosDetails : [PhotoDetails]! {
        didSet {
            self.bindingAcadamyPhotoDetails()
        }
    }
    
    private(set) var BookingPlanDetails : AcadamyBookingPlanModel! {
        didSet {
            self.bindingBookingPlanDetails()
        }
    }


   var bindingData : (() -> ()) = {}
    var bindingAcadamyPhotoDetails : (() -> ()) = {}
    var bindingBookingPlanDetails : (() -> ()) = {}


   func callSportsDataService(reqParam:Dictionary<String, String>) {
    let param :[String:String] = ["bus_id":"10"]
    APIHandler.shared.sendRequestAlomofire(url: "https://www.toptekker.com/turfdemo/index.php/api/get_sports", parameters: param, encoding: URLEncoding.httpBody, decoder: AcadamySportsModel.self) { (response, error) in
           if let response = response as? AcadamySportsModel{
               print(response)
            self.AcadamySportsDetails = response.data
           }else{
               print(error as Any)
           }
       }
   }
    
    func callAcadamyPhotoDataService(reqParam:Dictionary<String, String>) {
        APIHandler.shared.sendRequest(url: "http://www.toptekker.com/turfdemo/index.php/api/get_photos", parameters: reqParam, encoding: URLEncoding.httpBody, decoder: AcadamyPhotosModel.self) { (response, error) in
            if let response = response as? AcadamyPhotosModel{
                print(response)
             self.AcadamyPhotosDetails = response.data
            }else{
                print(error as Any)
            }
        }
    }

    func callSpecialTimingService(reqParam:Dictionary<String, String>) {
        APIHandler.shared.sendRequestAlomofire(url: "http://www.toptekker.com/turfdemo/index.php/api/get_user_subscriptions_and_special_timings", parameters: reqParam, encoding: URLEncoding.httpBody, decoder: AcadamyBookingPlanModel.self) { (response, error) in
            if let response = response as? AcadamyBookingPlanModel{
                print(response)
             self.BookingPlanDetails = response
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
    
//    func cancelAllRequest(){
//        AF.session.getAllTasks { (sessionTask) in
//            sessionTask.forEach{($0.cancel())}
//        }
//    }

}
