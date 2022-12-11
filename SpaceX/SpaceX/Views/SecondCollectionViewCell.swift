//
//  SecondCollectionViewCell.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "SecondCollectionViewCell"
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var rightLabel: UILabel = {
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
//        view.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .red
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
            leftLabel.widthAnchor.constraint(equalToConstant: 150),
            leftLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            
            rightLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            rightLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 0),
            rightLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
            
        ])
    }
}
