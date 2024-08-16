//
//  DevsKillerTestModel.swift
//  DevskillerTests
//
//  Created by Grey  on 16.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import XCTest
@testable import Devskiller

let mockHeadquarters = Headquarters(
    address: "Rocket Road",
    city: "Hawthorne",
    state: "California"
)

let mockLinks = Links(
    website: "https://www.spacex.com",
    flickr: "https://www.flickr.com/photos/spacex",
    twitter: "https://twitter.com/SpaceX",
    elonTwitter: "https://twitter.com/elonmusk"
)

let companyModel = CompanyModel(
    headquarters: mockHeadquarters,
    links: mockLinks,
    name: "SpaceX",
    founder: "Elon Musk",
    founded: 2002,
    employees: 9500,
    vehicles: 4,
    launchSites: 3,
    testSites: 2,
    ceo: "Elon Musk",
    cto: "Elon Musk",
    coo: "Gwynne Shotwell",
    ctoPropulsion: "Tom Mueller",
    valuation: 74000000000, // 74 billion USD
    summary: "SpaceX designs, manufactures and launches advanced rockets and spacecraft. The company was founded to revolutionize space technology, with the ultimate goal of enabling people to live on other planets.",
    id: "123456"
)



