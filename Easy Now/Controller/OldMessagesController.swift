//
//  OldMessagesController.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 20/11/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase

class OldMessagesController: UITableViewController {

     let ref = Database.database().reference()
    
    let cellId = "cellId"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showChatLogController"), object: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack2))
       
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
         checkUserAgain()
         //clickChat()
        
    }
    
    @IBOutlet weak var userNameLabel1: UILabel!

    func checkUserAgain(){
     
        if Auth.auth().currentUser?.uid == nil {
          
        } else {
            specificMessages()
        }
    
    }
    
    
    @objc func handleBack2(sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
   
    
    var messages = [Message]()
     var messagesDictionary = [String: Message]()
    
    
    
    func specificMessages(){
        
        
        guard let uid = Auth.auth().currentUser?.uid else {
           
            return
        }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                //                self.navigationItem.title = dictionary["name"] as? String
                
                self.userNameLabel1.text = dictionary["Username"] as? String
                let user = User(dictionary: dictionary)
               self.setUpNewMessages(user)
            }
            
        }, withCancel: nil)
    
                    
                }
    
    
  
    func setUpNewMessages(_ user: User){
        
        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()
        
        observeUserMessages()
        
    }
    
   
    
    func observeUserMessages(){
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
           
            let userId = snapshot.key
            Database.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
                
                let messageId = snapshot.key
                
                let messagesReference = Database.database().reference().child("messages").child(messageId)
                
                messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
               
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let message = Message(dictionary: dictionary)
                        
                        if let chatPartnerId = message.chatPartnerId() {
                            self.messagesDictionary[chatPartnerId] = message
                            
                            self.messages = Array(self.messagesDictionary.values)
                            self.messages.sort(by: {(message1, message2) -> Bool in
                                //self.messages.sort(by: { (message1, message2) -> Bool in
                                
                                return (message1.timestamp?.int32Value)! > (message2.timestamp?.int32Value)!
                            })
                            
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self.tableView.reloadData()
                        })
                    }
                    
                }, withCancel: nil)
                
            }, withCancel: nil)
            
            }, withCancel: nil)
       
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let message = messages[indexPath.row]
        cell.message = message
    
                  return cell
                    }
                
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 72
       
    }
    
    @IBOutlet var Chat: UITableView!
    
    var oldMessagesController: MessagesController!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = messages[indexPath.row]
        
        guard let chatPartnerId = message.chatPartnerId() else{
            return
        }
        
        let ref = Database.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            let user = User(dictionary: dictionary)
            user.id = chatPartnerId
            self.oldMessagesController?.showChatLogController(user)

            
        }, withCancel: nil)
        
        //clickChat()

          //  self.oldMessagesController?.showChatLogController(user)
            
        }
   //func clickChat(){
    
   //let oldmessageController = OldMessagesController()
    //oldmessageController.oldMessagesController = self
    //let navController = UINavigationController(rootViewController: oldmessageController)
    //present(navController, animated: true, completion: nil)
    
        //oldmessageController.oldMessagesController = self
       // let navController = UINavigationController(rootViewController: oldmessageController)
       //  present(navController, animated: true, completion: nil)
   //}

    }
    
  


