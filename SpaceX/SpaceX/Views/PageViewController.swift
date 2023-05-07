//
//  PageViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 11.12.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private var arrayOfControllers = [UIViewController]()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        for index in 0...3 {
            let viewModel = RocketViewModel(networkSevice: NetworkService())
            viewModel.index = index
            let viewController = RocketViewController(viewModel: viewModel)
            arrayOfControllers.append(viewController)
        }
        
        setViewControllers([arrayOfControllers[0]], direction: .forward, animated: true)
        view.tintColor = .white
        view.backgroundColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = arrayOfControllers.firstIndex(of: viewController) {
            if index > 0 {
                return arrayOfControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = arrayOfControllers.firstIndex(of: viewController) {
            if index < arrayOfControllers.count - 1 {
                return arrayOfControllers[index + 1]
            }
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayOfControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
