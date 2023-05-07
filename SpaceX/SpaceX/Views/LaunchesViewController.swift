//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 10.12.2022.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    private let viewModel: LaunchesViewModel
    
    private lazy var launchesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .white
        label.textAlignment = .center
        label.text = "So far there have been no launches."
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
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
        setupCollectionView()
        fetchData()
        setupBindings()
    }
    
    private func setupUI() {
        title = "Launches"
        view.backgroundColor = .black
        view.addSubview(errorLabel)
        view.addSubview(loadingIndicator)
        errorLabel.frame = view.bounds
        loadingIndicator.frame = view.bounds
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
        viewModel.getLaunches()
    }
    
    private func setupBindings() {
        viewModel.launches.bind { [weak self] launches in
            guard let launches else { return }
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.loadingIndicator.removeFromSuperview()
            }
            if launches.isEmpty {
                DispatchQueue.main.async {
                    self?.errorLabel.isHidden = false
                }
            } else {
                DispatchQueue.main.async {
                    self?.launchesCollectionView.reloadData()
                }
            }
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(116)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item]
        )
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
        return viewModel.launches.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.identifier, for: indexPath) as? LaunchCollectionViewCell else { return UICollectionViewCell() }
        if let launches = self.viewModel.launches.value {
            cell.configure(launch: launches[indexPath.item])
        }
        return cell
    }
}
