//
//  TTBaseViewController.swift
//  TopTekkar
//
//  Created by Murugesh on 03/09/21.
//

import Foundation
import UIKit

class TTBaseViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        self.viewControllers = setupVCs()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //self.viewControllers = [initialTabBar, finalTabBar]

    }
//    
//    lazy public var initialTabBar: HomeVC = {
//        
//        let initialTabBar = HomeVC()
//        
//        let title = "Tasks"
//
//        let defaultImage = UIImage(systemName: "homekit")!
//        
//        let selectedImage = UIImage(systemName: "homekit")!
//        
//        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)
//
//                
//        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: tabBarItems.selectedImage)
//        
//        initialTabBar.tabBarItem = tabBarItem
////        initialTabBar.tintColor = UIColor.whiteColor
//
//        return initialTabBar
//    }()
//    
//    lazy public var finalTabBar: NotificationVC = {
//        
//        let finalTabBar = NotificationVC()
//        
//        let defaultImage = UIImage(systemName: "homekit")
//        
//        let selectedImage = UIImage(systemName: "homekit")
//        
//        let tabBarItem = UITabBarItem(title: "My Tasks", image: defaultImage, selectedImage: selectedImage)
//        
//        finalTabBar.tabBarItem = tabBarItem
//        
//        return finalTabBar
//    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: UIImage) -> UIViewController {
          let navController = UINavigationController(rootViewController: rootViewController)
          navController.tabBarItem.title = title
          navController.tabBarItem.image = image
        navController.navigationBar.backgroundColor = UIColor.systemGreen
//          navController.navigationBar.prefersLargeTitles = true
          rootViewController.navigationItem.title = title
          navController.setNavigationBarHidden(false, animated: true)

          return navController
      }

    public func setupVCs() -> [UIViewController]{
        
        let firstController = self.getControllerFromStoryBoard(StoryBoardName: "Home", identifier: "Home", viewcontroller: HomeVC())
        
        let secondController = self.getControllerFromStoryBoard(StoryBoardName: "Home", identifier: "Home", viewcontroller: HomeVC())

        let thirdController = self.getControllerFromStoryBoard(StoryBoardName: "Home", identifier: "Home", viewcontroller: HomeVC())


        var viewControllers = [UIViewController]()
        viewControllers  = [
            createNavController(for: firstController, title: NSLocalizedString("Top tekkar", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: secondController, title: NSLocalizedString("Top tekkar", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: thirdController, title: NSLocalizedString("Top tekkar", comment: ""), image: UIImage(systemName: "person")!)
        ]
        return viewControllers
      }
    
    func getControllerFromStoryBoard(StoryBoardName:String,identifier:String,viewcontroller:UIViewController) -> UIViewController {
        
        let storyboard = UIStoryboard(name: StoryBoardName, bundle: nil)
        let viewController : UIViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        return viewController
        
    }

}




extension TTBaseViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
}

