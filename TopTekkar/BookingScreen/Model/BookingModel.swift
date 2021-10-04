//
//  BookingModel.swift
//  TopTekkar
//
//  Created by Murugesh on 19/09/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct BookingModel: Codable {
    let response: Bool
    let data: [BookingModelData]
    enum CodingKeys: String, CodingKey {
        case response = "responce"
        case data = "data"
    }
}

// MARK: - Datum
struct BookingModelData: Codable {
    let id, busID, serviceTitle, servicePrice: String
    let promoCode: String
    let convenienceFee: JSONNull
    let serviceDiscount, businessApproxtime, categories, image: String
    let advance,advanceType,convenienceFeeType :String

    enum CodingKeys: String, CodingKey {
        case id
        case busID = "bus_id"
        case serviceTitle = "service_title"
        case servicePrice = "service_price"
        case promoCode = "promo_code"
        case convenienceFee = "convenience_fee"
        case serviceDiscount = "service_discount"
        case businessApproxtime = "business_approxtime"
        case advance
        case advanceType = "advance_type"
        case convenienceFeeType = "convenience_fee_type"
        case categories, image
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
