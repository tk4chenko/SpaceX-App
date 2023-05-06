//
//  RocketViewModel.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 04.05.2023.
//

import Foundation

protocol RocketViewModelProtocol {
    var networkService: NetworkService { get }
    var rocket: Observable<Rocket?> { get }
    var errorMessage: Observable<String?> { get }
    var index: Int { get }
    func getRocket()
}

class RocketViewModel: RocketViewModelProtocol {
    
    let networkService: NetworkService
    var index: Int = 0
    
    init(networkSevice: NetworkService) {
        self.networkService = networkSevice
    }
    
    var rocket: Observable<Rocket?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    
    func getRocket() {
        networkService.get(urlString: "https://api.spacexdata.com/v4/rockets") { (result: Result<[Rocket], Error>) in
            switch result {
            case .success(let result):
                self.rocket.value = result[self.index]
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
