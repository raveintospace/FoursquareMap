//
//  Venue.swift
//  FoursquareMap
//
//  Created by Uri on 10/11/22.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]
}

// MARK: - Venue
struct Venue: Codable {
    let name: String
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
    let formattedAddress: [String]
}
