//
//  NewMessageController.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 18/11/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
       
    }
    
   func fetchUser(){
    Database.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
        
        if let dictionary = snapshot.value as? [String: AnyObject] {
     
        let user = User(dictionary: dictionary)
            user.id = snapshot.key
            self.users.append(user)
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
           
           
            
        }
    
    }, withCancel: nil)
    }
    
    
    @objc func handleBack(){
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.Username
        //cell.detailTextLabel?.text = user.email
        cell.detailTextLabel?.text = user.department
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    var messagesController: MessagesController!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("dismiss")
            let user = self.users[indexPath.row]
            self.messagesController?.showChatLogController(user)
       
        }
    }
    
    
}




