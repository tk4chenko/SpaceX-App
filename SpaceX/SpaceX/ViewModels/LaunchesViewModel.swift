//
//  LaunchesViewModel.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 04.05.2023.
//

import Foundation

protocol LaunchesViewModelProtocol {
    var networkService: NetworkService { get }
    var id: String { get }
    var launches: Observable<[Launch]?> { get }
    var errorMessage: Observable<String?> { get }
    func getLaunches()
}

class LaunchesViewModel: LaunchesViewModelProtocol {
    
    let networkService: NetworkService
    var id: String = ""
    
    init(networkSevice: NetworkService) {
        self.networkService = networkSevice
    }
    
    var launches: Observable<[Launch]?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    
    func getLaunches() {
        networkService.get(urlString: "https://api.spacexdata.com/v4/launches") { (result: Result<[Launch], Error>) in
            switch result {
            case .success(let result):
                self.launches.value = result.filter{ $0.rocket == self.id}
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
