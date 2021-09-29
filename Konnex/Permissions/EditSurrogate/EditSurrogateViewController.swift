//
//  EditSurrogateViewController.swift
//  TennantApp-IOS
//
//  Created by Mshiozaki on 2020-08-05.
//  Copyright © 2020 Konnex Enterprises. All rights reserved.
//

import UIKit

class EditSurrogateViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let konnexBlue = UIColor(red: 14.0/255.0, green: 70.0/255.0, blue: 161.0/255.0, alpha: 1)
    let konnexGray = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
    
    func newViewCont(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: viewController)
    }
    
    lazy var surrogatePages: [UIViewController] = {
        return [self.newViewCont(viewController: "EditSurrogatePage1"),
                self.newViewCont(viewController: "EditSurrogatePage2"),
                self.newViewCont(viewController: "EditSurrogatePage3")]
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
