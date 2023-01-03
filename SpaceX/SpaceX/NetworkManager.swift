//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    var arrayOfLaunches = [Launch]()
    
    var firstSection = [String: [Double]]()
    
    func loadRockets(index: Int, completion: @escaping (Rocket) -> Void) {
        let genresRequest = AF.request("https://api.spacexdata.com/v4/rockets", method: .get)
        genresRequest.responseDecodable(of: [Rocket].self) { response in
            do {
                let data = try response.result.get()
                
                completion(data[index])
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    func loadLaunches(id: String, completion: @escaping ([Launch]) -> Void) {
        let genresRequest = AF.request("https://api.spacexdata.com/v4/launches", method: .get)
        genresRequest.responseDecodable(of: [Launch].self) { response in
            do {
                let data = try response.result.get()
                self.arrayOfLaunches = data.filter({ launch in
                    return launch.rocket == id
                })
                completion(self.arrayOfLaunches)
            }
            catch {
                print("error: \(error)")
            }
        }
    }
}

extension String {
    func formattedDate(withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
