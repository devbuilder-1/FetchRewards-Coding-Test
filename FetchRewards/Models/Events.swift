//
//  EventsModal .swift
//  FetchRewards
//
//  Created by Prithiv Dev on 16/06/21.
//



import Foundation

// MARK: - Events
struct Events: Codable {
    
    let events: [Event]?
}

// MARK: - Event
struct Event: Codable {
    let type: String?
    let id: Double?
    let datetimeUTC: String?
    let venue: Venue?
    let performers: [Performer]?
    let datetimeLocal: String?
    let short_title: String?
    let visibleUntilUTC: String?
    let url: String?
    let score: Double?
    let announceDate: String?
    let createdAt: String?
    let title: String?
    let popularity: Double?
    let eventDescription: String?
    let status: String?
    let enddatetimeUTC: String?
}



// MARK: - Performer
struct Performer: Codable {
    let type: String?
    let name: String?
    let image: String?
    let id: Int?
    let imageAttribution: String?
    let url: String?
    let score: Double?
    let slug: String?
    let shortName: String?
    let numUpcomingEvents: Int?
    let imageLicense: String?
    let popularity: Int?
}


struct Location : Codable {
    let lat : Int?
    let lon : Int?
}

// MARK: - Venue
struct Venue: Codable {
    let state: String?
    let name_v2: String?
    let postal_code: String?
    let name: String?
    let timezone: String?
    let url: String?
   // let location: Location?
    let address: String?
    let country: String?
    let city: String?
    let slug: String?
    let extended_address: String?
    let id: Int?
    let metroCode: Int?
    let capacity: Int?
    let display_location: String?
}


