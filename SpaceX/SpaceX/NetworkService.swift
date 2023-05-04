//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() { }
    
    func loadRockets(index: Int, completion: @escaping (Rocket) -> Void) {
        AF.request("https://api.spacexdata.com/v4/rockets").responseDecodable(of: [Rocket].self) { response in
            switch response.result {
            case .success(let value):
                completion(value[index])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadLaunches(id: String, completion: @escaping ([Launch]) -> Void) {
        AF.request("https://api.spacexdata.com/v4/launches", method: .get).responseDecodable(of: [Launch].self) { response in
            switch response.result {
            case .success(let value):
                completion(value.filter({ $0.rocket == id }))
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
