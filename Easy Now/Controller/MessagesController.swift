//
//  MainController.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 19/11/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func showChatLogController(_ user: User){
            
            let chatLogController = ChatLogController()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // let ChatLogController = storyboard.instantiateViewController(withIdentifier: "archivedMessage")
            chatLogController.user = user
            let navController = UINavigationController(rootViewController: chatLogController)
            present(navController, animated: true, completion: nil)
            
        }
        
        
        
        
        func handleNewMessage(){
            let newMessageController = NewMessageController()
            newMessageController.messagesController = self
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // let NewMessageController = storyboard.instantiateViewController(withIdentifier: "newMessage")
            // newMessageController.messagesController = self
            let navController = UINavigationController(rootViewController: newMessageController)
            present(navController, animated: true, completion: nil)
            
        }

    
}
}
