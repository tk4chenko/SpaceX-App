//
//  SettingsViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    weak var delegate: RefreshViewDelegate?
    
    let userDefaults = UserDefaults.standard
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
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var myView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addBlur(style: .systemChromeMaterialDark)
        return view
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
    
    @objc func buttonAction() {
        delegate?.refreshView()
        self.dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSwitchState()
        view.addSubview(myView)
        myView.frame = view.bounds
        view.backgroundColor = .clear
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        guard let firstVC = presentedViewController as? RocketViewController else { return }
//        firstVC.myCollectionView.reloadData()
//    }
    
    private func checkSwitchState() {
        if userDefaults.bool(forKey: heightKey) {
            self.heightSwitch.setOn(true, animated: false)
            self.heightLabel.text = "M"
            userDefaults.synchronize()
        } else {
            self.heightLabel.text = "Ft"
            self.heightSwitch.setOn(false, animated: false)
            userDefaults.synchronize()
        }
    }
    
    private func setupConstraints() {
        view.addSubview(leftHeightLabel)
        view.addSubview(heightLabel)
        view.addSubview(heightSwitch)
        view.addSubview(topLabel)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topLabel.heightAnchor.constraint(equalToConstant: 40),
            
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            button.widthAnchor.constraint(equalToConstant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            heightSwitch.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 70),
            heightSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            leftHeightLabel.centerYAnchor.constraint(equalTo: heightSwitch.centerYAnchor),
            leftHeightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            leftHeightLabel.widthAnchor.constraint(equalToConstant: 200),
            leftHeightLabel.heightAnchor.constraint(equalToConstant: 40),
            
            heightLabel.centerYAnchor.constraint(equalTo: heightSwitch.centerYAnchor),
            heightLabel.widthAnchor.constraint(equalToConstant: 40),
            heightLabel.trailingAnchor.constraint(equalTo: heightSwitch.leadingAnchor, constant: 0),
            heightLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}
