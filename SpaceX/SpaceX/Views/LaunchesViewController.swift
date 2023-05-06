//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    var viewModel: LaunchesViewModel?

    private lazy var launchesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "So far there have been no launches."
        label.alpha = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    init(viewModel: LaunchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        setupBindings()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        title = "Launches"
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
    }
       
    private func setupCollectionView() {
        view.addSubview(launchesCollectionView)
        launchesCollectionView.frame = view.bounds
        
        launchesCollectionView.dataSource = self
        launchesCollectionView.delegate = self

        launchesCollectionView.register(LaunchCollectionViewCell.self, forCellWithReuseIdentifier: LaunchCollectionViewCell.identifier)
    }
    
    private func fetchData() {
        viewModel?.getLaunches()
    }
    
    private func setupBindings() {
        viewModel?.launches.bind { [weak self] launches in
            print(launches)
            if launches != nil {
                DispatchQueue.main.async {
                    self?.launchesCollectionView.reloadData()
                }
            }
        }
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
    
    private func setupConstraints() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
        ])
    }
}

extension LaunchesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.launches.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.identifier, for: indexPath) as? LaunchCollectionViewCell else { return UICollectionViewCell() }
        if let launches = self.viewModel?.launches.value {
            cell.configure(launch: launches[indexPath.item])
            print(launches)
        }
        
        return cell
    }
    
}
