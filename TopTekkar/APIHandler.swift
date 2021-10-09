//
//  APIHandler.swift
//  TopTekkar
//
//  Created by Murugesh on 07/09/21.
//

import Foundation
import Alamofire
class APIHandler: NSObject, URLSessionDelegate {
    static let shared = APIHandler()
    
    private lazy var queue: DispatchQueue = {
        let domainName = "com.ts.apiServices_userInteractive"
        let apiQueue = DispatchQueue(label: domainName, qos: DispatchQoS.userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
        return apiQueue
    }()
    
    private lazy var backgroundQueue: DispatchQueue = {
        let apiQueue = DispatchQueue(label: "com.ts.apiServices_background", qos: DispatchQoS.background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
        return apiQueue
    }()

    func sendRequestAlomofire<T:Decodable>(url: String, parameters: [String: String]?,encoding:ParameterEncoding, decoder:T.Type, completion: @escaping (Any, Error?) -> Void){
        let queue: APIQueue = .background
       
        let que: DispatchQueue = (queue == .userInteractive) ? self.queue : self.backgroundQueue
        let utilityQueue = DispatchQueue.global(qos: .utility)

        AF.request(url,method: .post,parameters: parameters,encoding:encoding).responseDecodable(of: decoder,queue: utilityQueue, decoder: JSONDecoder()) { response in
//=======
//        AF.request(url,method: .post, parameters: parameters).responseDecodable(of: decoder,queue: .main, decoder: JSONDecoder()) { response in
//>>>>>>> 3f620a1aed722d3d9df2a050f28c1c601c094575
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
    
    
    func sendRequest<T:Decodable>(url: String, parameters: [String: Any]?,encoding:ParameterEncoding, decoder:T.Type,completion: @escaping (Any, Error?) -> Void){
        let url = URL(string: url)
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        if let parameters = parameters {
            do {

                request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted) // pass dictionary to data object and set it as request body
            } catch let error {
                print(error.localizedDescription)
                completion(AnyObject.self, error)
            }

        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")


//        request.setValue("application/json", forHTTPHeaderField: "Accept")
////        request.setValue("text/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        var encodeJSONData: Data?
//        request.httpBody = encodeJSONData
//
//        do {
//            let encoder = JSONEncoder()
//
////            encodeJSONData =  try JSONEncoder().encode()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
        
//        let configuration =
//            URLSessionConfiguration.default
//
//        let session = URLSession(configuration: configuration,
//            delegate: self,
//            delegateQueue:OperationQueue.main)
//
//
//        let task = session.dataTaskWithRequest(request){
//            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
//
//            if let httpResponse = response as? NSHTTPURLResponse {
//                if httpResponse.statusCode != 200 {
//                    print("response was not 200: \(response)")
//                    return
//                }
//                else
//                {
//                    print("response was 200: \(response)")
//
//                    print("Data for 200: \(data)")
//
//                    // In the callback you can return the data/response
//                    callback(data, nil)
//                    return
//                }
//            }
//            if (error != nil) {
//                print("error request:\n \(error)")
//                //Here you can return the error and handle it accordingly
//                return
//            }
//        }
//        task.resume()

        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters ?? [])
        request.httpBody = jsonData

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        let session = URLSession(configuration: sessionConfig,
            delegate: self,
            delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in


                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}
                    do{

                        let data = try JSONDecoder().decode(decoder.self, from: data)

                        completion(data, nil)
                    }catch let jsonErr{
                        completion([], error)
                        print(jsonErr.localizedDescription)
                   }

            }
            task.resume()
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
    
    enum APIQueue {
        case background
        case userInteractive
    }

}
