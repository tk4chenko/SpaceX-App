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
    
    var firstSectionArray = [Double]()
    var secondSectionArray = [String]()
    var firstStageSection = [String]()
    var secondStageSection = [String]()
    
    func loadRockets(index: Int, completion: @escaping (Rocket) -> Void) {
        let genresRequest = AF.request("https://api.spacexdata.com/v4/rockets", method: .get)
        genresRequest.responseDecodable(of: [Rocket].self) { response in
            do {
                let data = try response.result.get()
                self.arrayOfRockets = data
                
//                MARK: - First array
                var firstArrray = [Double]()
                firstArrray.append(data[index].height?.meters ?? 0)
                firstArrray.append(data[index].diameter?.meters ?? 0)
                firstArrray.append(Double(data[index].mass?.kg ?? 0))
                firstArrray.append(Double(data[index].payload_weights?[0].kg ?? 0))
                self.firstSectionArray = firstArrray
                firstArrray.removeAll()
                
//                MARK: - Second array
                var secondArray = [String]()
                secondArray.append(data[index].first_flight?.formattedDate(withFormat: "MMM dd, yyyy") ?? "HUY")
                secondArray.append(data[index].country ?? "")
                secondArray.append("$" + String((Double(data[index].cost_per_launch ?? 0)) / 10000000) + " mln")
                self.secondSectionArray = secondArray
                secondArray.removeAll()
                
//                MARK: - Third array
                var thirdArray = [String]()
                thirdArray.append(String(data[index].first_stage?.engines ?? 0))
                thirdArray.append(String(Int(data[index].first_stage?.fuel_amount_tons ?? 0)) + " ton")
                thirdArray.append(String(data[index].first_stage?.burn_time_sec ?? 0) + " sec")
                self.firstStageSection = thirdArray
                thirdArray.removeAll()
                
//                MARK: - Fourth array
                var fourthArray = [String]()
                fourthArray.append(String(data[index].second_stage?.engines ?? 0))
                fourthArray.append(String(Int(data[index].second_stage?.fuel_amount_tons ?? 0)) + " ton")
                fourthArray.append(String(data[index].second_stage?.burn_time_sec ?? 0) + " sec")
                self.secondStageSection = fourthArray
                fourthArray.removeAll()
                
                completion(data[index])
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
