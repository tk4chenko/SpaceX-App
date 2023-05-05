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
    func getRocket(by index: Int)
}

class RocketViewModel: RocketViewModelProtocol {
    let networkService: NetworkService
    
    init(networkSevice: NetworkService) {
        self.networkService = networkSevice
    }
    
    var rocket: Observable<Rocket?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    
    func getRocket(by index: Int) {
        networkService.get(urlString: "https://api.spacexdata.com/v4/rockets") { (result: Result<[Rocket], Error>) in
            switch result {
            case .success(let result):
                self.rocket.value = result[index]
                print(result)
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
