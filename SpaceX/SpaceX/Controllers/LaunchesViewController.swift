//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import UIKit

class LaunchesViewController: UIViewController {

    private lazy var launchesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        
        title = "Launches"
        
        
        view.addSubview(launchesCollectionView)
        
        launchesCollectionView.frame = view.bounds
        
        launchesCollectionView.dataSource = self
        launchesCollectionView.delegate = self

        launchesCollectionView.register(LaunchCollectionViewCell.self, forCellWithReuseIdentifier: LaunchCollectionViewCell.identifier)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(116))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets.bottom = 16
            group.contentInsets.leading = 32
            group.contentInsets.trailing = 32
            let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 40
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
}

extension LaunchesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.identifier, for: indexPath) as? LaunchCollectionViewCell else { return UICollectionViewCell() }
//        cell.leftLabel.text = thirdSectionArray[indexPath.row]
//        cell.rightLabel.text = thirdfSectionArray2[indexPath.row]
        return cell
    }
    
    
}
