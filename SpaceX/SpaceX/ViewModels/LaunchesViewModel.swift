//
//  LaunchesViewModel.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 04.05.2023.
//

import Foundation

class LaunchesViewModel {
    let networkService: NetworkService
    
    init(networkSevice: NetworkService) {
        self.networkService = networkSevice
    }
}
