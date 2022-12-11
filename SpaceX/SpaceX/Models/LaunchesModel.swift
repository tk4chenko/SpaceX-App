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
    let net: Bool?
    let rocket: String?
    let success: Bool?
    let name: String?
    let date_local: String?
    let id: String
}
