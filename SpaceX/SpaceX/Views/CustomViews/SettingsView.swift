//
//  SettingsView.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 26.12.2022.
//

import UIKit

enum Settings: String, CaseIterable {
    case Height, Diameter, Mass, Payload
    
    var description: [String] {
        switch self {
        case .Height: return ["m", "ft"]
        case .Diameter: return ["m", "ft"]
        case .Mass: return ["kg", "lb"]
        case .Payload: return ["kg", "lb"]
        }
    }
}

class SettingsView: UIView {
    
    var param: Settings?
    
    let userDefaults = UserDefaults()
    let heightKey = "HeightKey"
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 40))
        segmentController.addTarget(self, action: #selector(SettingsView.segmentTapped), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var segmentController: UISegmentedControl = {
        let items = ["m", "ft"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 1
        control.translatesAutoresizingMaskIntoConstraints = false
        control.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)]
        control.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleTextAttributes2 = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)]
        control.setTitleTextAttributes(titleTextAttributes2, for: .selected)
        return control
    }()
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    @objc func segmentTapped() {
        print("TAPPED")
        guard let param = self.param else { return }
        userDefaults.set(segmentController.selectedSegmentIndex, forKey: param.rawValue)
    }
    
    public func configure(param: Settings) {
        leftLabel.text = param.rawValue
        
        self.param = param
        
        segmentController.selectedSegmentIndex = userDefaults.integer(forKey: param.rawValue)
        
        segmentController.setTitle(param.description[0], forSegmentAt: 0)
        segmentController.setTitle(param.description[1], forSegmentAt: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
    }
    
    private func configureConstraints() {
        self.addSubview(leftLabel)
        self.addSubview(segmentController)
        NSLayoutConstraint.activate([
            segmentController.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28),
            segmentController.heightAnchor.constraint(equalToConstant: 40),
            segmentController.widthAnchor.constraint(equalToConstant: 115),
            segmentController.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            leftLabel.centerYAnchor.constraint(equalTo: segmentController.centerYAnchor),
            leftLabel.trailingAnchor.constraint(equalTo: segmentController.leadingAnchor, constant: 0),
            leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28),
            leftLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

}
