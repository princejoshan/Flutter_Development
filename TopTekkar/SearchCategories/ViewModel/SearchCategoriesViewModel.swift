//
//  SearchCategoriesViewModel.swift
//  TopTekkar
//
//  Created by Murugesh on 05/09/21.
//

import Foundation
import Alamofire

class SearchCategoriesViewModel {
    
    private(set) var categoryData : [SearchCategoriesDataModel]! {
        didSet {
            self.bindingData()
        }
    }
    
    var bindingData : (() -> ()) = {}
    
    func fetchData() {
        APIHandler.shared.sendRequest(url: "https://www.toptekker.com/turfdemo/index.php/api/get_categories", parameters: nil, encoding: URLEncoding.default, decoder: SearchCategoriesModel.self) { (response, error) in
            if let response = response as? SearchCategoriesModel{
                print(response)
                self.categoryData = response.data
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
