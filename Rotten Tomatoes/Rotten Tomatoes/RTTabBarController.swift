//
//  RTTabBarController.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/18/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class RTTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tabItems = self.tabBar.items!
        for (index, vc) in self.childViewControllers.enumerate() {
            if let navigationController = vc as? UINavigationController {
                if let movieController = navigationController.topViewController as? MovieTableViewController {
                    let tabItem = tabItems[index]
                    switch index {
                    case MovieTableViewController.DataType.BoxOffice.rawValue:
                        movieController.setRTDataType(MovieTableViewController.DataType.BoxOffice)
                        tabItem.title = "Box Office"
                        tabItem.image = UIImage(named: "clapper");
                        movieController.navigationItem.title = "Box Office"
                    case MovieTableViewController.DataType.DVD.rawValue:
                        movieController.setRTDataType(MovieTableViewController.DataType.DVD)
                        tabItem.title = "DVD"
                        tabItem.image = UIImage(named: "disc");
                        movieController.navigationItem.title = "DVD"
                    default:
                        movieController.setRTDataType(MovieTableViewController.DataType.BoxOffice)
                        tabItem.title = "Box Office"
                        tabItem.image = UIImage(named: "clapper");
                        navigationController.title = "Box Office"
                        movieController.navigationItem.title = "Box Office"
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
