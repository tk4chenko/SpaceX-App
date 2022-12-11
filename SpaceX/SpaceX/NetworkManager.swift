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
    
    var arrayOfRockets = [Rocket]()
    var arrayOfLaunches = [Launch]()
    var arrayOfDiameter = [Double]()
    var secondSectionArray = [String]()
    var firstStageSection = [String]()
    
    var rocket: Rocket!
    
    func loadRockets(completion: @escaping () -> Void) {
        let genresRequest = AF.request("https://api.spacexdata.com/v4/rockets", method: .get)
        genresRequest.responseDecodable(of: [Rocket].self) { response in
            do {
                let data = try response.result.get()
                self.arrayOfRockets = data
                
                self.arrayOfDiameter.append(data.first?.height?.meters ?? 0)
                self.arrayOfDiameter.append(data.first?.diameter?.meters ?? 0)
                self.arrayOfDiameter.append(Double(data.first?.mass?.kg ?? 0))
                
                self.secondSectionArray.append(data.first?.first_flight?.formattedDateFromString(withFormat: "MMM dd, yyyy") ?? "HUY")
                self.secondSectionArray.append(data.first?.country ?? "")
                self.secondSectionArray.append("$" + String((Double(data.first?.cost_per_launch ?? 0)) / 10000000) + " mln")
                
                self.firstStageSection.append(String(data.first?.first_stage?.engines ?? 0))
                self.firstStageSection.append(String(Int(data.first?.first_stage?.fuel_amount_tons ?? 0)) + " ton")
                self.firstStageSection.append(String(data.first?.first_stage?.burn_time_sec ?? 0) + " sec")

                self.rocket = data.first
                completion()
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    func loadLaunches(completion: @escaping () -> Void) {
        let genresRequest = AF.request("https://api.spacexdata.com/v4/launches", method: .get)
        genresRequest.responseDecodable(of: [Launch].self) { response in
            do {
                let data = try response.result.get()
                self.arrayOfLaunches = data
                print(data)
                completion()
            }
            catch {
                print("error: \(error)")
            }
        }
    }
}
