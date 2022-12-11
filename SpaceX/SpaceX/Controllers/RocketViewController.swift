//
//  ViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 08.12.2022.
//

import UIKit
import SDWebImage

class RocketViewController: UIViewController {
    
    var index = Int()
    var id = String()
    
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height * 1.6)

    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(RocketViewController.tappedMe))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
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
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See launches", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        button.layer.cornerRadius = 12
        button.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.loadRockets(index: self.index) { rocket in
            self.id = rocket.id ?? "no id"
            self.label.text = rocket.name
            guard let url = URL(string: rocket.flickr_images?.first ?? "") else { return }
            self.backgroundImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.backgroundImage.sd_setImage(with: url, completed: nil)
            self.myCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        myCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.identifier)
        myCollectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.headerID)
    }
    
    private func firstSectionLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 6
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(116), heightDimension: .absolute(116))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func secondSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(46))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 24
        return section
    }
    
    private func thirdSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(46))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(60.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, enviroment) -> NSCollectionLayoutSection? in
            if sectionNumber ==  0 {
                return self.firstSectionLayout()
            } else if sectionNumber ==  1 {
                return self.secondSectionLayout()
            } else {
                return self.thirdSectionLayout()
            }
        }
    }
    
    @objc func tappedMe(){
        let viewController = SettingsViewController()
        present(viewController, animated: true)
    }
    
    @objc func buttonAction() {
        let vc = LaunchesViewController()
        vc.configure(id: self.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(backgroundImage)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.addSubview(button)
        containerView.addSubview(mainView)
        mainView.addSubview(label)
        scrollView.addSubview(settingsImage)
        scrollView.addSubview(myCollectionView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
    
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainView.heightAnchor.constraint(equalToConstant: contentViewSize.height),
            mainView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: view.frame.height / 2),
            
            myCollectionView.heightAnchor.constraint(equalToConstant: 680),
            myCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
            myCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            myCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            
            button.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 56),
            button.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32),
            button.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            
            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 48),
            
            settingsImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -35),
            settingsImage.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            settingsImage.widthAnchor.constraint(equalToConstant: 32),
            settingsImage.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
}
extension RocketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.headerID, for: indexPath) as! Header
    
        if indexPath.section == 2 {
            header.label.text = "FIRST STAGE"
        } else {
            header.label.text = "SECOND STAGE"
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return NetworkManager.shared.firstSectionArray.count
        } else {
            return NetworkManager.shared.secondSectionArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return
                UICollectionViewCell() }
            let value = NetworkManager.shared.firstSectionArray
            cell.configureCell(amounts: value, indexPath: indexPath)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.identifier, for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
            let value = NetworkManager.shared.secondSectionArray
            cell.configure(section: .second, value: value, indexPath: indexPath)
            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.identifier, for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
            let value = NetworkManager.shared.firstStageSection
            cell.configure(section: .stage, value: value, indexPath: indexPath)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.identifier, for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
            let value = NetworkManager.shared.secondStageSection
            cell.configure(section: .stage, value: value, indexPath: indexPath)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
}
