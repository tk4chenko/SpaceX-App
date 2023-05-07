//
//  ViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 08.12.2022.
//

import UIKit

final class RocketViewController: UIViewController {
    
    private let viewModel: RocketViewModelProtocol
    
    private lazy var myCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let navView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addBlur(style: .systemChromeMaterialDark)
        return view
    }()
    
    private let navLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var settingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gearshape")
        imageView.tintColor = UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer(target: self, action: #selector(RocketViewController.openSettings))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
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
    
    init(viewModel: RocketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCollectionView()
        fetchData()
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    private func setupCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        myCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.identifier)
        myCollectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.headerID)
    }
    
    private func fetchData() {
        viewModel.getRocket()
    }
    
    private func setupBindings() {
        viewModel.rocket.bind { [weak self] rocket in
            if let rocket {
                DispatchQueue.main.async {
                    self?.setupUI(with: rocket)
                }
            }
        }
    }
    
    private func setupUI(with rocket: Rocket) {
        self.navLabel.text = rocket.name
        self.label.text = rocket.name
        if let url = URL(string: rocket.flickrImages?.randomElement() ?? "") {
            self.backgroundImage.loadImage(from: url)
        }
        self.myCollectionView.reloadData()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, enviroment) -> NSCollectionLayoutSection? in
            if sectionNumber ==  0 {
                return self.myCollectionView.firstSectionLayout()
            } else if sectionNumber ==  1 {
                return self.myCollectionView.secondSectionLayout()
            } else {
                return self.myCollectionView.thirdSectionLayout()
            }
        }
    }
    
    @objc func openSettings(){
        let viewController = SettingsViewController()
        viewController.reloadDara = { [weak self] in
            self?.myCollectionView.reloadData()
        }
        present(viewController, animated: true)
    }
    
    @objc func buttonAction() {
        let viewModel = LaunchesViewModel(networkSevice: NetworkService())
        viewModel.id = self.viewModel.rocket.value?.id ?? ""
        let viewController = LaunchesViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([backgroundImage, backgroundView, label, settingsImage, button, myCollectionView])
        view.addSubview(navView)
        navView.addSubview(navLabel)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1280),
            
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.54),
            
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -32),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            label.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            label.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 48),
            
            myCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
            myCollectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            myCollectionView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            myCollectionView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16),
            
            button.heightAnchor.constraint(equalToConstant: 56),
            button.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
            button.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            button.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -24),
            
            settingsImage.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -35),
            settingsImage.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            settingsImage.widthAnchor.constraint(equalToConstant: 32),
            settingsImage.heightAnchor.constraint(equalToConstant: 32),
            
            navView.topAnchor.constraint(equalTo: view.topAnchor),
            navView.heightAnchor.constraint(equalToConstant: 86),
            navView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            navLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            navLabel.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -10)
        ])
    }
}

extension RocketViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = ((scrollView.contentOffset.y - view.frame.height / 2) + 100) / (label.frame.height + 48)
        let clearToWhite = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        navLabel.textColor = clearToWhite
        navView.alpha = offset
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
            return 4
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return }
        guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.identifier, for: indexPath) as? SecondCollectionViewCell else { return }
        cell.alpha = 0
        cell2.alpha = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return
            UICollectionViewCell() }
        guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.identifier, for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
        if let rocket = viewModel.rocket.value {
            switch indexPath.section {
            case 0:
                cell.configureCell(rocket: rocket, indexPath: indexPath, setting:  Settings.allCases[indexPath.row])
                cell.alpha = 1
                return cell
            case 1, 2, 3:
                cell2.configureByRocket(rocket: rocket, indexPath: indexPath)
                cell2.alpha = 1
                return cell2
            default:
                return cell
            }
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
}
