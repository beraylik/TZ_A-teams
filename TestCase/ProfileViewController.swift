//
//  ProfileViewController.swift
//  TestCase
//
//  Created by Gena Beraylik on 06.10.2017.
//  Copyright © 2017 Beraylik. All rights reserved.
//

import UIKit
import Contacts

class ProfileViewController: UITableViewController {

    var contact = CNContact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        
        //configureAppearence()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 1 {
            cell.textLabel?.text = contact.phoneNumbers[indexPath.row].value.stringValue
        } else if indexPath.section == 2 {
            cell.textLabel?.text = contact.emailAddresses[indexPath.row].value.substring(from: 0)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return contact.phoneNumbers.count
        case 2:
            return contact.emailAddresses.count
        default:
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(50.0)
        return height
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.backgroundColor = .white
        
        var visualVertConstraint = "V:|-20-[v0]-10-|"
        
        switch section {
        case 0:
            label.text = contact.givenName + " " + contact.familyName
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 44.0)
            visualVertConstraint = "V:|-50-[v0]-50-|"
        case 1:
            label.text = "Phone Number:"
        case 2:
            label.text = "E-Mail:"
        default:
            label.text = ""
        }
        
        let view = UIView()
        view.addSubview(label)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": label]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualVertConstraint, options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": label]))
        
        return view
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
