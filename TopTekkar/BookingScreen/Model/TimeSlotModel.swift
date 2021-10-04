import Foundation

// MARK: - Welcome
struct TimeSlot: Codable {
    let response: Bool
    let data: TimeSlotSection
    enum CodingKeys: String, CodingKey {
        case response = "responce"
        case data = "data"
    }
}

// MARK: - DataClass
struct TimeSlotSection: Codable {
    let morning, afternoon, evening: [TimeSlotDetailArray]
}

// MARK: - Afternoon
struct TimeSlotDetailArray: Codable {
    let slot, slotLabel, interval, bookingID: String
    let isBooked, isMembership: Bool
    let planID, type, price: String
    let timeToken: Int

    enum CodingKeys: String, CodingKey {
        case slot
        case slotLabel = "slot_label"
        case interval
        case bookingID = "booking_id"
        case isBooked = "is_booked"
        case isMembership = "is_membership"
        case planID = "plan_id"
        case type, price
        case timeToken = "time_token"
    }
}

struct TimeSlotRequestData{
    let date:String
    let turf_id:String
    let category:String
    let bus_id:String
    let user_type_id:String
    let type:String
    let plan_id:String
    let cat_id:String
    let user_id:String
    
}

