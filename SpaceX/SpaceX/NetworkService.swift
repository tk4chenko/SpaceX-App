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
    
    func loadRockets(index: Int, completion: @escaping(Rocket) -> Void) {
        AF.request("https://api.spacexdata.com/v4/rockets").responseDecodable(of: [Rocket].self) { response in
            switch response.result {
            case .success(let value):
                completion(value[index])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadLaunches(id: String, completion: @escaping([Launch]) -> Void) {
        AF.request("https://api.spacexdata.com/v4/launches", method: .get).responseDecodable(of: [Launch].self) { response in
            switch response.result {
            case .success(let value):
                completion(value.filter({ $0.rocket == id }))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func get<T: Decodable>(urlString: String, completion: @escaping(Result<T, Error>)-> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responce = try decoder.decode(T.self, from: data)
                print(responce)
                completion(.success(responce))
            } catch {
                completion(.failure(error))
            }
        })
        task.resume()
    }
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "api.spacexdata.com"
    }
}


enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}


enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
