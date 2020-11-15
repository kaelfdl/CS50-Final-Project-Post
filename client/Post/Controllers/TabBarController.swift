//
//  ViewController.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/23/20.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab Bar Controllers
        let homeVC = HomeVC()
        let exploreVC = ExploreVC()
        let accountVC = AccountVC()
        
        // Tab Bar Icons
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        exploreVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)))
        
        accountVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        // Tab Bar Tint Color
        UITabBar.appearance().tintColor = .systemGray
        
        let controllers = [homeVC, exploreVC, accountVC]
        
        // Tab Bar View Controller Property
        viewControllers = controllers.map {UINavigationController(rootViewController: $0)}
        
        
    }
    
}

