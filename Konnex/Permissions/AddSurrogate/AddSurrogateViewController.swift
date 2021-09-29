//
//  AddSurrogateViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-07-19.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

//struct Surrogate {
//    var name: String
//    var title: String
//    var email: String
//    var phone: String
//    var photo: UIImage?
//    var isTemporarySurrogate: Bool
//    var startDate: String?
//    var startTime: String?
//    var endDate: String?
//    var endTime: String?
//    var sendEmail: Bool
//}

class AddSurrogateViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func newViewCont(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: viewController)
    }
    
    lazy var surrogatePages: [UIViewController] = {
        return [self.newViewCont(viewController: "AddSurrogatePage1"),
                self.newViewCont(viewController: "AddSurrogatePage2"),
                self.newViewCont(viewController: "AddSurrogatePage3")]
    }()
    
    var pageControl = UIPageControl()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 125, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = surrogatePages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = konnexBlue
        self.pageControl.pageIndicatorTintColor = konnexGray
        self.pageControl.currentPageIndicatorTintColor = konnexBlue
        self.pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        configurePageControl()
        
        if let firstViewController = surrogatePages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = surrogatePages.firstIndex(of: viewController) else { return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard surrogatePages.count > previousIndex else {
            return nil
        }
        return surrogatePages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = surrogatePages.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let surrogatePagesCount = surrogatePages.count
        
        guard surrogatePagesCount != nextIndex else {
            return nil
        }
        guard surrogatePagesCount > nextIndex else {
            return nil
        }
        return surrogatePages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = surrogatePages.firstIndex(of: pageContentViewController)!
    }
}
