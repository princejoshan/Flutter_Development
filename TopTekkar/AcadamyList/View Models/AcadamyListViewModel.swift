//
//  VenueViewModel.swift
//  TopTekkar
//
//  Created by Prince  on 18/09/21.
//

import Foundation
import Alamofire

 class AcadamyListViewModel {
    private(set) var AcadamyData : [AcadamyDetails]! {
        didSet {
            self.bindingData()
        }
    }
    
    var bindingData : (() -> ()) = {}
    
    func callVenueDataService(reqParam:Dictionary<String, String>) {
        APIHandler.shared.sendRequest(url: "https://www.toptekker.com/turfdemo/index.php/api/get_business", parameters: reqParam, decoder: AcadamyListModel.self) { (response, error) in
            if let response = response as? AcadamyListModel{
                print(response)
                self.AcadamyData = response.data
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
