//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import Foundation
import Alamofire

enum FirstSection: String {
    case height, diameter, mass, payload
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let userDefaults = UserDefaults.standard
    
    var arrayOfLaunches = [Launch]()
    
    var id = String()
    
    var firstSectionArray = [Double]()
    
    var firstSectionDict = [String: [Double]]()
    
    var secondSectionArray = [String]()
    var firstStageSection = [String]()
    var secondStageSection = [String]()
    var dict = [String: [String: [String]]]()
    
    
    func loadRockets(index: Int, completion: @escaping (Rocket) -> Void) {
        let genresRequest = AF.request("https://api.spacexdata.com/v4/rockets", method: .get)
        genresRequest.responseDecodable(of: [Rocket].self) { response in
            do {
                let data = try response.result.get()
                
                self.id = data[index].id ?? ""

                // MARK: - First array
                var firstArrray = [Double]()
                
                if self.userDefaults.bool(forKey: "HeightKey") {
                    firstArrray.append(data[index].height?.meters ?? 0)
                } else {
                    firstArrray.append(data[index].height?.feet ?? 0)
                }
                firstArrray.append(data[index].diameter?.meters ?? 0)
                firstArrray.append(Double(data[index].mass?.kg ?? 0))
                firstArrray.append(Double(data[index].payload_weights?[0].kg ?? 0))
                self.firstSectionArray = firstArrray
                firstArrray.removeAll()
                
                // MARK: - First dict
                var dict = [String: [Double]]()
                dict.updateValue([data[index].height?.meters ?? 0, data[index].height?.feet ?? 0], forKey: FirstSection.height.rawValue)

                self.firstSectionDict = dict
                // MARK: - Second array
                var secondArray = [String]()
                secondArray.append(data[index].first_flight?.formattedDate(withFormat: "MMM dd, yyyy") ?? "HUY")
                secondArray.append(data[index].country ?? "")
                secondArray.append("$" + String((Double(data[index].cost_per_launch ?? 0)) / 10000000) + " mln")
                self.secondSectionArray = secondArray
                secondArray.removeAll()
                // MARK: - Third array
                var thirdArray = [String]()
                thirdArray.append(String(data[index].first_stage?.engines ?? 0))
                thirdArray.append(String(Int(data[index].first_stage?.fuel_amount_tons ?? 0)) + " ton")
                thirdArray.append(String(data[index].first_stage?.burn_time_sec ?? 0) + " sec")
                self.firstStageSection = thirdArray
                thirdArray.removeAll()
                // MARK: - Fourth array
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

//                for rocket in data {
//                    self.dict.updateValue([Rockets.height.rawValue : [String(rocket.height?.meters ?? 0), String(rocket.height?.feet ?? 0) ]], forKey: rocket.name ?? "")
//                }
//
//                print(self.dict)

//                var firstDict = [String :[Double]]()
//                firstDict.updateValue([data[index].height?.meters ?? 0, data[index].height?.feet ?? 0], forKey: FirstSection.height.rawValue)
//                firstDict.updateValue([data[index].diameter?.meters ?? 0, data[index].diameter?.feet ?? 0], forKey: FirstSection.diameter.rawValue)
//                firstDict.updateValue([Double(data[index].mass?.kg ?? 0), Double(data[index].mass?.lb ?? 0)], forKey: FirstSection.mass.rawValue)
//                firstDict.updateValue([Double(data[index].payload_weights?[0].kg ?? 0), Double(data[index].payload_weights?[0].lb ?? 0)], forKey: FirstSection.payload.rawValue)
//
//                print(firstDict)
