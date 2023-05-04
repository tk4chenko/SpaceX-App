//
//  RocketViewModel.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 04.05.2023.
//

import Foundation

class RocketViewModel {
    let networkService: NetworkService
    
    init(networkSevice: NetworkService) {
        self.networkService = networkSevice
    }
}
