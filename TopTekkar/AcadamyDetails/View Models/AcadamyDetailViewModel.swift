//
//  AcadamyDetailViewModel.swift
//  TopTekkar
//
//  Created by Prince  on 20/09/21.
//

import Foundation


class AcadamyDetailViewModel {
   private(set) var AcadamySportsDetails : [sportsDetails]! {
       didSet {
           self.bindingData()
       }
   }
   
   var bindingData : (() -> ()) = {}
   
   func callSportsDataService(reqParam:Dictionary<String, String>) {
       APIHandler.shared.sendRequest(url: "http://www.toptekker.com/turfdemo/api/get_sports", parameters: reqParam, decoder: AcadamySportsModel.self) { (response, error) in
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

}
