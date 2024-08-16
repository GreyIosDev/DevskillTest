//
//  AllLanchesModel.swift
//  Devskiller
//
//  Created by Grey  on 09.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let links: Linkss
    let rocket: String
    let success: Bool?
    let name, dateUTC: String
    let datePrecision: String

    enum CodingKeys: String, CodingKey {
        case links
        case success
        case rocket
        case name
        case dateUTC = "date_utc"
        case datePrecision = "date_precision"
    }
}

// MARK: - Core
struct Core: Codable {
    let core: String
    let flight: Int
    let gridfins, legs, reused, landingAttempt: Bool
    let landingSuccess: Bool
    let landingType, landpad: String

    enum CodingKeys: String, CodingKey {
        case core, flight, gridfins, legs, reused
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
        case landpad
    }
}

// MARK: - Links
struct Linkss: Codable {
    let flickr: Flickr
    let patch: Patch?
    let wikipedia: String?
}

// MARK: - Flickr
struct Flickr: Codable {
    let original: [String]
}

// MARK: - Patch
struct Patch: Codable {
    let small, large: String?
}
