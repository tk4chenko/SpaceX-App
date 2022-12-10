//
//  ViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 08.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height + 200)
    
    let arrayOfAmounts = ["229.6", "39.9", "3,125,735", "140,660"]
    let arrayOfValues = ["Height, ft", "Diameter, ft", "Mass, lb", "Load, lb"]
    
    private lazy var myCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        view.layer.cornerRadius = 32
        return view
    }()
    
    private lazy var settingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gearshape")
        imageView.tintColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedMe))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nasa")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SpaceXlogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.frame.size = contentViewSize
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = scrollView.bounds
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Falcon Heavy"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = contentViewSize
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        view.addSubview(backgroundImage)
        view.addSubview(logoImage)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(mainView)
        mainView.addSubview(label)
        scrollView.addSubview(settingsImage)
        scrollView.addSubview(myCollectionView)
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 6
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(116), heightDimension: .absolute(116))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                heightDimension: .estimated(50.0))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
//                                                                 elementKind: UICollectionView.elementKindSectionHeader,
//                                                                 alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
//        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @objc func tappedMe(){
        print("PRESSED")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            setupConstraints()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            
            logoImage.widthAnchor.constraint(equalToConstant: 120),
            logoImage.heightAnchor.constraint(equalToConstant: 35),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -4),
            
            backgroundImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            backgroundImage.heightAnchor.constraint(equalToConstant: view.frame.height),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            
            mainView.widthAnchor.constraint(equalToConstant: containerView.frame.width),
            mainView.heightAnchor.constraint(equalToConstant: view.frame.height + 200),
            mainView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 300),
            
            myCollectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            myCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
            myCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            myCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
        
            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 48),
            
            settingsImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -35),
            settingsImage.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            settingsImage.widthAnchor.constraint(equalToConstant: 32),
            settingsImage.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
//        cell.configute()
        cell.amountLabel.text = arrayOfAmounts[indexPath.row]
        cell.heightLabel.text = arrayOfValues[indexPath.row]
        return cell
    }

}
