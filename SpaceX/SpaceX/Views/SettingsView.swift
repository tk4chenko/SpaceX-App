//
//  SettingsView.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 26.12.2022.
//

import UIKit

class SettingsView: UIView {
    
    let userDefaults = UserDefaults()
    let heightKey = "HeightKey"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let segmentController: UISegmentedControl = {
        let items = ["m", "ft"]
        let control = UISegmentedControl(items: items)
        control.addTarget(SettingsView.self, action: #selector(segmentPressed), for: .allEvents)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        return control
    }()
    
    lazy var leftHeightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    @objc func segmentPressed() {
        print("PRESSED")
    }
    
//    @objc func heightSwitchChange(_ sender:UISwitch!) {
//        if (sender.isOn == true){
//            userDefaults.set(true, forKey: heightKey)
//            userDefaults.synchronize()
//        }
//        else{
//            userDefaults.set(false, forKey: heightKey)
//            userDefaults.synchronize()
//        }
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
    }
    
    private func configureConstraints() {
        self.addSubview(leftHeightLabel)
        self.addSubview(segmentController)
        NSLayoutConstraint.activate([
            segmentController.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            segmentController.heightAnchor.constraint(equalToConstant: 20),
            segmentController.widthAnchor.constraint(equalToConstant: 100),
            segmentController.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
//            leftHeightLabel.centerYAnchor.constraint(equalTo: heightSwitch.centerYAnchor),
            leftHeightLabel.widthAnchor.constraint(equalToConstant: 40),
            leftHeightLabel.trailingAnchor.constraint(equalTo: segmentController.leadingAnchor, constant: 0),
            leftHeightLabel.heightAnchor.constraint(equalToConstant: 40),
        
        
        ])
    }

}
