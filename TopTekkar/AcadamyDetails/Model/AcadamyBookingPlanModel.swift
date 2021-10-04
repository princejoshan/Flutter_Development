//
//  AcadamyBookingPlanModel.swift
//  TopTekkar
//
//  Created by Prince  on 21/09/21.
//

import Foundation
struct AcadamyBookingPlanModel: Codable {
    let responce: Bool
    let data: [Datum]
    let specialTimings: [SpecialTiming]

    enum CodingKeys: String, CodingKey {
        case responce, data
        case specialTimings = "special_timings"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id, busID, trainerID, name: String
    let datumDescription, validity, noOfHours, startTime: String
    let endTime, days, fee, payAdvance: String
    let convenienceFee, totalMembers, enrolledMembers, category: String
    let datumStatus, createdAt, status, categoryName: String
    let acadamyName: String
    let trainerName, trainerPhoto: JSONNull?
    let acadamyLogo, hoursPlayed, endAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case busID = "bus_id"
        case trainerID = "trainer_id"
        case name
        case datumDescription = "description"
        case validity
        case noOfHours = "no_of_hours"
        case startTime = "start_time"
        case endTime = "end_time"
        case days, fee
        case payAdvance = "pay_advance"
        case convenienceFee = "convenience_fee"
        case totalMembers = "total_members"
        case enrolledMembers = "enrolled_members"
        case category
        case datumStatus = "status"
        case createdAt = "created_at"
        case status = "Status"
        case categoryName = "category_name"
        case acadamyName = "acadamy_name"
        case trainerName = "trainer_name"
        case trainerPhoto = "trainer_photo"
        case acadamyLogo = "acadamy_logo"
        case hoursPlayed = "hours_played"
        case endAt = "end_at"
    }
}

// MARK: - SpecialTiming
struct SpecialTiming: Codable {
    let id, busID, title, categories: String
    let workingDays, morningTimeStart, morningTimeEnd, afternoonTimeStart: String
    let afternoonTimeEnd, eveningTimeStart, eveningTimeEnd, morningPrice: String
    let afternoonPrice, eveningPrice, morningEnabled, afternoonEnabled: String
    let eveningEnabled, createdAt, categoriesTitle: String

    enum CodingKeys: String, CodingKey {
        case id
        case busID = "bus_id"
        case title, categories
        case workingDays = "working_days"
        case morningTimeStart = "morning_time_start"
        case morningTimeEnd = "morning_time_end"
        case afternoonTimeStart = "afternoon_time_start"
        case afternoonTimeEnd = "afternoon_time_end"
        case eveningTimeStart = "evening_time_start"
        case eveningTimeEnd = "evening_time_end"
        case morningPrice = "morning_price"
        case afternoonPrice = "afternoon_price"
        case eveningPrice = "evening_price"
        case morningEnabled = "morning_enabled"
        case afternoonEnabled = "afternoon_enabled"
        case eveningEnabled = "evening_enabled"
        case createdAt = "created_at"
        case categoriesTitle = "categories_title"
    }
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
