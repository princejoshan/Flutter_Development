//
//  SearchCategoriesModel.swift
//  TopTekkar
//
//  Created by Murugesh on 05/09/21.
//

import UIKit


struct SearchCategoriesModel: Codable {
    let response:Bool
    let data: [SearchCategoriesDataModel]
    
    enum CodingKeys: String, CodingKey {
        case response = "responce"
        case data = "data"
    }
    
}

struct SearchCategoriesDataModel : Codable{
    
    let Count: String
    let PCount: String
    let description: String
    let id : String
    let level : String
    let parent : String
    let slug : String
    let status : String
    let title : String
    let image : String

    enum CodingKeys: String, CodingKey {
        case Count
        case PCount
        case description
        case id
        case level = "leval"
        case parent
        case slug
        case status
        case title
        case image
    }
}
