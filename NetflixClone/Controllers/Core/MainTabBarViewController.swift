//
//  ViewController.swift
//  NetflixClone
//
//  Created by ekincare on 07/10/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: TopSearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house");
        vc2.tabBarItem.image = UIImage(systemName: "play.circle");
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass");
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line");
        
        vc1.title = "Home"
        vc2.title = "Upcoming"
        vc3.title = "Top Search"
        vc4.title = "Downdoads"
        
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
        
    }


}

