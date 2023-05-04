//
//  Header.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import UIKit

class Header: UICollectionReusableView {
    
    static let headerID = "headerID"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = self.bounds
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraint()
    }
    
    private func setupConstraint() {
        self.addSubview(mainView)
        mainView.addSubview(label)
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            mainView.heightAnchor.constraint(equalToConstant: 40),
            
            label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
        ])
    }
}
