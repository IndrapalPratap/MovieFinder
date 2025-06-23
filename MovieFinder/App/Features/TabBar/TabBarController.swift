//
//  TabBarController.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 20/06/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTabs()
        setupTabsUi()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupTabs() {
        let homeVC = loadViewController(fromStoryboard: StoryboardName.home, identifier: ViewControllerID.homeVC)
        homeVC.tabBarItem = UITabBarItem(title: TabBarTitle.home, image: UIImage(named: TabBarIcon.home), tag: 0)
        
        let searchVC = loadViewController(fromStoryboard: StoryboardName.search, identifier: ViewControllerID.searchVC)
        searchVC.tabBarItem = UITabBarItem(title: TabBarTitle.search, image: UIImage(named: TabBarIcon.search), tag: 1)
        
        let favouriteVC = loadViewController(fromStoryboard: StoryboardName.favourite, identifier: ViewControllerID.favouriteVC)
        favouriteVC.tabBarItem = UITabBarItem(title: TabBarTitle.favourite, image: UIImage(named: TabBarIcon.favourite), tag: 2)
        
        viewControllers = [homeVC, searchVC, favouriteVC]
    }
    
    // This function is used for find the view controller object
    private func loadViewController(fromStoryboard name: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    private func setupTabsUi() {
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = .customDarkPurple
        tabBar.backgroundColor = .customDarkPurple
        tabBar.tintColor = .tabBarSelected
        tabBar.unselectedItemTintColor = .tabBarUnselected
        
        // Optional: remove top shadow for flat design
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        // Tint for selected and unselected items
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .white
        
        // Adjust tab bar items spacing and style
        if let items = tabBar.items {
            for item in items {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
                item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 2, right: 0)
                item.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
                item.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            }
        }
        
    }
}
