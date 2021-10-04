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
   
   var bindingData : (() -> ()) = {}
   
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
