//
//  ChatTableViewController.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 30/10/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase


class MainController: UIViewController{
   
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
        
    
        if Auth.auth().currentUser?.uid == nil{
            logout()
            
        }
        setuprofile()
        
       
    }// set the username in the label
    @IBOutlet weak var usernameLabel: UILabel!
    
    func setuprofile(){
        if let uid = Auth.auth().currentUser?.uid{
            
            ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    self.usernameLabel.text = dict["Username"] as? String
                    
                    
                }
            });print("Username")
            
            
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
        
     //let storyboard = UIStoryboard(name: "Main", bundle: nil)
     // let NewMessageController = storyboard.instantiateViewController(withIdentifier: "newMessage")
       // newMessageController.messagesController = self
       let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)

    }
    
    
    
    @IBAction func archivedMessages(_ sender: Any) {
       // handleArchive(user: User)
    }
    
    
    func showChatLogController(_ user: User){
       
        let chatLogController = ChatLogController()
      
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
  // let ChatLogController = storyboard.instantiateViewController(withIdentifier: "archivedMessage")
        chatLogController.user = user
        let navController = UINavigationController(rootViewController: chatLogController)
        present(navController, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func Messages(_ sender: Any) {
        seeMessages()
    }
    
    func seeMessages(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MessagesController = storyboard.instantiateViewController(withIdentifier: "messages")
        let navController = UINavigationController(rootViewController: MessagesController)
        present(navController, animated: true, completion: nil)
      
        
    }
    
  
    
    
}











//hide the keyboard
extension MessagesController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
}


