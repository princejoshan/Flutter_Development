//
//  AcadamySports.swift
//  TopTekkar
//
//  Created by Prince  on 20/09/21.
//

import Foundation

struct AcadamySportsModel: Codable {
    let response: Bool
    let data: [SportsDetails]
    
    enum CodingKeys: String, CodingKey {
        case response = "responce"
        case data = "data"
    }
    
}

// MARK: - Datum
struct SportsDetails: Codable {
    let id:String
    let busID:String
    let categoryID:String
    let title: String
    let slug: String
    let parent: String
    let leval: String
    let datumDescription: String
    let image :String
    let status: String

    enum CodingKeys: String, CodingKey {
        case id
        case busID = "bus_id"
        case categoryID = "category_id"
        case title, slug, parent, leval
        case datumDescription = "description"
        case image, status
    }
}

struct SportDetailsRequest {
    let busId :String
}
