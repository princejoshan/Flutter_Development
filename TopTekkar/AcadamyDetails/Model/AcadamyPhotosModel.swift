//
//  AcadamyPhotosModel.swift
//  TopTekkar
//
//  Created by Prince  on 21/09/21.
//

import Foundation
struct AcadamyPhotosModel: Codable {
    let responce: Bool
    let data: [PhotoDetails]
}

// MARK: - Datum
struct PhotoDetails: Codable {
    let id, busID, photoTitle, photoImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case busID = "bus_id"
        case photoTitle = "photo_title"
        case photoImage = "photo_image"
    }
}
