//
//  ViewController.swift
//  TestCase
//
//  Created by Gena Beraylik on 05.10.2017.
//  Copyright © 2017 Beraylik. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UITableViewController {

    let cellID = "CellID"
    var contactStore = CNContactStore()
    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        contactStore = CNContactStore.init()
        requestContactsAccess()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func requestContactsAccess() {
        contacts = []
        contactStore.requestAccess(for: .contacts, completionHandler: {granted, error in
            if granted {
                print("Granted")
            } else {
                print("Not granted")
            }
        })
        
        do {
            let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
            
            try self.contactStore.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                self.contacts.append(contact)
            })
            self.view.reloadInputViews()
            print("There are \(contacts.count) contacts")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

        let profileView = ProfileViewController()
        profileView.contact = contacts[indexPath.row]
        
        navigationController?.pushViewController(profileView, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currentContact = contacts[indexPath.row]
        cell.textLabel?.text = "\(currentContact.givenName) \(currentContact.familyName)"
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

