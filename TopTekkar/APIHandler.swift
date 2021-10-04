//
//  APIHandler.swift
//  TopTekkar
//
//  Created by Murugesh on 07/09/21.
//

import Foundation
import Alamofire
class APIHandler {
    static let shared = APIHandler()
    

    func sendRequest<T:Decodable>(url: String, parameters: [String: String]?, decoder:T.Type, completion: @escaping (Any, Error?) -> Void){

        AF.request(url,method: .post, parameters: parameters).responseDecodable(of: decoder,queue: .main, decoder: JSONDecoder()) { response in
            switch response.result {
            case let .success(data):
                // success
                completion(data, nil)
            case let .failure(error):
                // error
                completion([], error)
                print(error.localizedDescription)
            }
        }

    }
    
    func downloadRequest(url: String, completion: @escaping (Any, Error?) -> Void){
        AF.request(url,method: .get).response{ response in

         switch response.result {
          case .success(let responseData):
            completion(responseData, nil)
            print(responseData)
          case .failure(let error):
              print("error--->",error)
            completion([], error)
          }
    }

}
}
