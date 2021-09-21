//
//  AcadamySports.swift
//  TopTekkar
//
//  Created by Prince  on 20/09/21.
//

import Foundation

struct AcadamySportsModel: Codable {
    let responce: Bool
    let data: [sportsDetails]
}

// MARK: - Datum
struct sportsDetails: Codable {
    let id, busID, categoryID, title: String
    let slug, parent, leval, datumDescription: String
    let image, status: String

    enum CodingKeys: String, CodingKey {
        case id
        case busID = "bus_id"
        case categoryID = "category_id"
        case title, slug, parent, leval
        case datumDescription = "description"
        case image, status
    }
}
