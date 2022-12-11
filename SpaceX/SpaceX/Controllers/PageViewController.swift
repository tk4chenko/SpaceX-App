//
//  PageViewController.swift
//  SpaceX
//
//  Created by Artem Tkachenko on 11.12.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var arrayOfControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vC = RocketViewController()
        let vC2 = RocketViewController()
        let vC3 = RocketViewController()
        
        dataSource = self
        
        arrayOfControllers.append(contentsOf: [vC, vC2, vC3])
        setViewControllers([arrayOfControllers[0]], direction: .forward, animated: true)
        
//        view.backgroundColor = .red
        
    }


}

extension PageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        <#code#>
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        <#code#>
    }
    
    
}
