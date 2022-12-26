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

    lazy var heightSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(self.heightSwitchChange(_:)), for: .valueChanged)
        mySwitch.setOn(true, animated: false)
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.onTintColor = .darkGray
        return mySwitch
    }()
    
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "M"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
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
    
    @objc func heightSwitchChange(_ sender:UISwitch!) {
        if (sender.isOn == true){
            self.heightLabel.text = "M"
            userDefaults.set(true, forKey: heightKey)
            userDefaults.synchronize()
        }
        else{
            self.heightLabel.text = "Ft"
            userDefaults.set(false, forKey: heightKey)
            userDefaults.synchronize()
        }
    }

}
