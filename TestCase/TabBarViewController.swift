//
//  TabBarViewController.swift
//  TestCase
//
//  Created by Gena Beraylik on 05.10.2017.
//  Copyright © 2017 Beraylik. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .red
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let layout = UICollectionViewFlowLayout()
        let restTab = JsonViewController(collectionViewLayout: layout)
        let restNavi = UINavigationController(rootViewController: restTab)
        let restBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        restNavi.tabBarItem = restBarItem
        
        let contactsTab = ContactsViewController()
        let contactsNavi = UINavigationController(rootViewController: contactsTab)
        let contactsBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        contactsNavi.tabBarItem = contactsBarItem
        
        self.viewControllers = [restNavi, contactsNavi]
        
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
