//
//  LaunchesModel.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import Foundation

import Foundation
// MARK: - LaunchesModels
struct Launch: Decodable {
    let fairings: Fairings?
    let links: Links?
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let net: Bool?
    let window: Int?
    let rocket: Rocket?
    let success: Bool?
    let failures: [Failure]?
    let details: String?
    let crew, ships, capsules, payloads: [String]?
    let launchpad: Launchpad?
    let flightNumber: Int?
    let name, dateUTC: String?
    let dateUnix: Int?
    let dateLocal: Date?
    let datePrecision: DatePrecision?
    let upcoming: Bool?
    let cores: [Core]?
    let autoUpdate, tbd: Bool?
    let launchLibraryID: String?
    let id: String?
}

extension Launch {
    // MARK: - Core
    struct Core: Decodable {
        let core: String?
        let flight: Int?
        let gridfins, legs, reused, landingAttempt: Bool?
        let landingSuccess: Bool?
        let landingType: LandingType?
        let landpad: Landpad?
    }
}

extension Launch.Core {
    // MARK: - LandingType
    enum LandingType: Decodable {
        case asds
        case ocean
        case rtls
    }
}

extension Launch.Core {
    // MARK: - Landpad
    enum Landpad: Decodable {
        case the5E9E3032383Ecb267A34E7C7
        case the5E9E3032383Ecb554034E7C9
        case the5E9E3032383Ecb6Bb234E7CA
        case the5E9E3032383Ecb761634E7Cb
        case the5E9E3032383Ecb90A834E7C8
        case the5E9E3033383Ecb075134E7CD
        case the5E9E3033383Ecbb9E534E7Cc
    }
}

extension Launch {
    // MARK: - DatePrecision
    enum DatePrecision: Decodable {
        case day
        case hour
        case month
    }
}

extension Launch {
    // MARK: - Failure
    struct Failure: Decodable {
        let time: Int?
        let altitude: Int?
        let reason: String?
    }
}

extension Launch {
    // MARK: - Fairings
    struct Fairings: Decodable {
        let reused, recoveryAttempt, recovered: Bool?
        let ships: [String]?
    }
}

extension Launch {
    // MARK: - Launchpad
    enum Launchpad: Decodable {
        case the5E9E4501F509094Ba4566F84
        case the5E9E4502F509092B78566F87
        case the5E9E4502F509094188566F88
        case the5E9E4502F5090995De566F86
    }
}

extension Launch {
    // MARK: - Links
    struct Links: Decodable {
        let patch: Patch?
        let reddit: Reddit?
        let flickr: Flickr?
        let presskit: String?
        let webcast: String?
        let youtubeID: String?
        let article: String?
        let wikipedia: String?
    }
}

extension Launch.Links {
    // MARK: - Flickr
    struct Flickr: Decodable {
        let small: [String]?
        let original: [String]?
    }
}

extension Launch.Links {
    // MARK: - Patch
    struct Patch: Decodable {
        let small, large: String?
    }
}

extension Launch.Links {
    // MARK: - Reddit
    struct Reddit: Decodable {
        let campaign: String?
        let launch: String?
        let media, recovery: String?
    }
}
