//
//  SecondCollectionViewCell.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import UIKit

enum Section {
    case second
    case stage
}

class SecondCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "SecondCollectionViewCell"
    
    private let secondSectionArray = ["First start", "County", "Launch cost"]
    private let stageSectionArray = ["Number of engines", "Fuel quantity", "Сombustion time"]
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = contentView.bounds
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraint()
    }
    
//    public func configure(section: Section, value: [String], indexPath: IndexPath) {
//        rightLabel.text = value[indexPath.row]
//        switch section {
//        case .second:
//            leftLabel.text = secondSectionArray[indexPath.row]
//        case .stage:
//            leftLabel.text = stageSectionArray[indexPath.row]
//        }
//    }
    
    public func configureByRocket(rocket: Rocket, indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                rightLabel.text = rocket.firstFlight?.formattedDate(withFormat: "MMM dd, yyyy")
            case 1:
                rightLabel.text = rocket.country
            case 2:
                rightLabel.text = "$\(Double(rocket.costPerLaunch ?? 0) / 10000000) mln"
            default:
                return
            }
            leftLabel.text = secondSectionArray[indexPath.row]
        case 2:
            switch indexPath.row {
            case 0:
                rightLabel.text = "\(rocket.firstStage?.engines ?? 0)"
            case 1:
                rightLabel.text = "\(rocket.firstStage?.fuelAmountTons ?? 0) ton"
            case 2:
                rightLabel.text = "\(rocket.firstStage?.burnTimeSec ?? 0) sec"
            default:
                return
            }
            leftLabel.text = stageSectionArray[indexPath.row]
        case 3:
            switch indexPath.row {
            case 0:
                rightLabel.text = "\(rocket.secondStage?.engines ?? 0)"
            case 1:
                rightLabel.text = "\(rocket.secondStage?.fuelAmountTons ?? 0) ton"
            case 2:
                rightLabel.text = "\(rocket.secondStage?.burnTimeSec ?? 0) sec"
            default:
                return
            }
            leftLabel.text = stageSectionArray[indexPath.row]
        default:
            return
        }
    }
    
    private func setupConstraint() {
        contentView.addSubview(mainView)
        mainView.addSubview(leftLabel)
        mainView.addSubview(rightLabel)
        
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            leftLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            leftLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            leftLabel.trailingAnchor.constraint(equalTo: rightLabel.leadingAnchor, constant: 0),
            leftLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            
            rightLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            rightLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 0),
            rightLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
        ])
    }
}

