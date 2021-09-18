//
//  VenueModel.swift
//  TopTekkar
//
//  Created by Murugesh on 11/09/21.
//

import UIKit

struct AcadamyListModel: Codable {
    let responce: Bool
    let data: [AcadamyDetails]
}

// MARK: - Datum
struct AcadamyDetails: Codable {
    let busID, userID, busTitle, busSlug: String
    let busEmail, busDescription, busGoogleStreet, busLatitude: String
    let busLongitude, busContact, busLogo, busStatus: String
    let startTime, endTime, cityID, countryID: String
    let localityID, isTrusted, facilities, razorpayAcc: String
    let payAdvance, advanceAmount, fcmTopic, currency: String
    let userFullname, avgRating, totalRating, reviewCount: String

    enum CodingKeys: String, CodingKey {
        case busID = "bus_id"
        case userID = "user_id"
        case busTitle = "bus_title"
        case busSlug = "bus_slug"
        case busEmail = "bus_email"
        case busDescription = "bus_description"
        case busGoogleStreet = "bus_google_street"
        case busLatitude = "bus_latitude"
        case busLongitude = "bus_longitude"
        case busContact = "bus_contact"
        case busLogo = "bus_logo"
        case busStatus = "bus_status"
        case startTime = "start_time"
        case endTime = "end_time"
        case cityID = "city_id"
        case countryID = "country_id"
        case localityID = "locality_id"
        case isTrusted = "is_trusted"
        case facilities
        case razorpayAcc = "razorpay_acc"
        case payAdvance = "pay_advance"
        case advanceAmount = "advance_amount"
        case fcmTopic = "fcm_topic"
        case currency
        case userFullname = "user_fullname"
        case avgRating = "avg_rating"
        case totalRating = "total_rating"
        case reviewCount = "review_count"
    }
}
