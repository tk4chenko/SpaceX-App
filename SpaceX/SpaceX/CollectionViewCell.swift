//
//  CollectionViewCell.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 09.12.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static var identifier = "CollectionViewCell"
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraint()
    }
    
        public func configute() {
            amountLabel.text = "229.6"
            heightLabel.text = "Height, ft"
    
        }
    
    private func setupConstraint() {
        contentView.addSubview(mainView)
        mainView.addSubview(amountLabel)
        mainView.addSubview(heightLabel)
        
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            amountLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -10),
            amountLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            amountLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            
            heightLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            heightLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            heightLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8)
            
        ])
    }
}
