//
//  CollectionViewCell.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 09.12.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static var identifier = "CollectionViewCell"
    
    let userDefaults = UserDefaults.standard
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = contentView.bounds
        view.layer.cornerRadius = 32
        view.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        return view
    }()
    
    public func configureCell(value: [Double], key: String) {
        if userDefaults.bool(forKey: "HeightKey") {
            amountLabel.text = "\(value[0])"
            unitLabel.text = key + ", m"
        } else {
            amountLabel.text = "\(value[1])"
            unitLabel.text = key + ", ft"
        }
        
    }
    
    public func configureByRocket(rocket: Rocket) {
        if userDefaults.bool(forKey: "HeightKey") {
            amountLabel.text = "\(rocket.height?.meters ?? 0)"
            unitLabel.text = "Height, m"
        } else {
            amountLabel.text = "\(rocket.height?.feet ?? 0)"
            unitLabel.text = "Height, ft"
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraint()
    }
    
    private func setupConstraint() {
        contentView.addSubview(mainView)
        mainView.addSubview(amountLabel)
        mainView.addSubview(unitLabel)
        
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            amountLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -10),
            amountLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            amountLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            
            unitLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            unitLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            unitLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8)
        ])
    }
}
