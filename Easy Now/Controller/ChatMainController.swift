//
//  ChatMainController.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 20/11/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase

class ChatMainController: UIViewController {
    
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
    
    
   
        
    
    
    @IBAction func archivedMessages(_ sender: Any) {
        // handleArchive(user: User)
    }
    
    @IBAction func newMessage(_ sender: Any) {
        //handleNewMessage()
    }
    
    
    
   
    
    
}


