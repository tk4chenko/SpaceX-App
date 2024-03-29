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
    
    public func configureCell(rocket: Rocket,indexPath: IndexPath, setting: Settings) {
        let int = userDefaults.integer(forKey: setting.rawValue)
        switch indexPath.item {
        case 0:
            if int == 0 {
                amountLabel.text = "\(rocket.height?.meters ?? 0)"
            } else {
                amountLabel.text = "\(rocket.height?.feet ?? 0)"
            }
        case 1:
            if int == 0 {
                amountLabel.text = String(rocket.diameter?.meters ?? 0)
            } else {
                amountLabel.text = String(rocket.diameter?.feet ?? 0)
            }
        case 2:
            if int == 0 {
                amountLabel.text = String(rocket.mass?.kg ?? 0)
            } else {
                amountLabel.text = String(rocket.mass?.lb ?? 0)
            }
        case 3:
            guard let payload = rocket.payloadWeights else { return }
            if int == 0 {
                amountLabel.text = "\(payload[0].kg ?? 0)"
            } else {
                amountLabel.text = "\(payload[0].lb ?? 0)"
            }
        default:
            break
        }
        unitLabel.text = "\(setting.rawValue), \(setting.description[int])"
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
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            amountLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -10),
            amountLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            amountLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            
            unitLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            unitLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            unitLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8)
        ])
    }
}
