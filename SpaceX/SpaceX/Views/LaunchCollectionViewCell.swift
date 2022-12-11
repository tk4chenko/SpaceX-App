//
//  LaunchCollectionViewCell.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "LaunchCell"
    
    private lazy var rocketImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rocket")
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedMe))
//        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "FalconSat"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "2 February, 2022"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = contentView.bounds
        view.layer.cornerRadius = 24
        view.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
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
        mainView.addSubview(topLabel)
        mainView.addSubview(bottomLabel)
        mainView.addSubview(rocketImage)
        
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            topLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24),
            topLabel.widthAnchor.constraint(equalToConstant: 100),
            topLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            bottomLabel.widthAnchor.constraint(equalToConstant: 200),
            bottomLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            
            rocketImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 35),
            rocketImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -33),
            rocketImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
