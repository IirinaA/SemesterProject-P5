//
//  ChatTableViewController.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 30/10/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase


class MessagesController: UIViewController{
   
    let ref = Database.database().reference()
    
   //menu bar
    

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuButton: UIButton!
   @IBAction func menuButtonPressed(_ sender: Any) {
        
        if(menuView.isHidden == true){
            menuView.isHidden = false
        }else{
            menuView.isHidden = true
       }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         //NotificationCenter.default.addObserver(self, selector: #selector(showChatLogController), name: NSNotification.Name(rawValue: "showChatLogController"), object: nil)
        
        if Auth.auth().currentUser?.uid == nil{
            logout()
        }
        setuprofile()
        
        
    }
    @IBOutlet weak var usernameLabel: UILabel!
    
    func setuprofile(){
        if let uid = Auth.auth().currentUser?.uid{
            ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]
                {
                    self.usernameLabel.text = dictionary["Username"] as? String
                   
                   
                }
            });
            
          
        }
        
   
    }
    
    
    

    //handle logout
  @IBAction func logOut(_ sender: Any) {
    logout()
  }
    
  func logout(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginnViewController = storyboard.instantiateViewController(withIdentifier: "login")
      present(LoginnViewController, animated: true, completion: nil)
    
   }

    
   @IBAction func newMessage(_ sender: Any) {
        handleNewMessage()
    }
    
    
    func handleNewMessage(){
        let newMessageController = NewMessageController()
        newMessageController.messagesController = self
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
        
    }
 

    @objc func showChatLogController(_ user: User){
    
       
  let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
      chatLogController.user = user
        let navController = UINavigationController(rootViewController: chatLogController)
        present(navController, animated: true, completion: nil)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    

    
  
    @IBAction func oldMessage(_ sender: Any) {
       displayoldMessages()
    }
    func displayoldMessages(){
        
        //let oldmessageController = OldMessagesController()
       //oldmessageController.oldMessagesController = self
       // OldMessagesController.oldMessagesController = self
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let OldMessagesController = storyboard.instantiateViewController(withIdentifier: "oldMessages")
        present(OldMessagesController, animated: true, completion: nil)
        //let navController = UINavigationController(rootViewController:  oldmessageController)
       // present(navController, animated: true, completion: nil)
    }
    
}


//hide the keyboard
extension MessagesController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
   
}



