//
//  RegisterViewController.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 01/11/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase



class RegisterViewController: UIViewController, UITextFieldDelegate {
 
    var oldMessagesController: OldMessagesController!
    
    let ref = Database.database().reference()
   

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!

    
    
    
    @IBAction func backButton(_ sender: Any) {
        
         self.performSegue(withIdentifier: "loginpage", sender: self)
        
        
    }
    @IBAction func registerButton(_ sender: Any) {

        
        
        //checking if the password is correct
        if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            //here the user is created
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if error == nil {
                    
                self.performSegue(withIdentifier: "mainpage", sender: self)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    
    
                    }
               let uid = Auth.auth().currentUser!.uid
           
                //save the user with the username in Firebase database
           
                
                //the next line creates a node in the database
                let userReference = self.ref.child("users").child(uid)
          
                let values = ["Username": self.userName.text!, "email": self.email.text!, "department": self.menuOutlet.titleLabel?.text]
                userReference.updateChildValues(values, withCompletionBlock :{(err, ref) in
                     if err != nil{
                      print(error!)
                      return
                     }
                    
                    let user = User(dictionary: values as [String : AnyObject])
                    self.oldMessagesController?.setUpNewMessages(user)
                })
  
           }
                     }
        
        if let user = Auth.auth().currentUser
        {
            user.getIDToken { token, error in
                guard error == nil, let token = token else {
                   // Log.error("Get ID Token with error: \(error?.localizedDescription ?? “unknown error”)“)
                    return
                }
            }
        }
        
        if Auth.auth().currentUser?.uid != nil {
            
            
            self.performSegue(withIdentifier: "mainpage", sender: self)
        } else {
            //User Not logged in
        }
        }


    
    //department
    @IBOutlet var departmentCollection: [UIButton]!
    @IBOutlet weak var menuOutlet: UIButton!
    @IBAction func handleSelection(_ sender: UIButton) {
        departmentCollection.forEach{(button) in
            UIView.animate(withDuration: 0.25, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }

    }
   
    
    @IBAction func departmentTapped(_ sender: UIButton) {
        menuOutlet.titleLabel?.text = sender.titleLabel?.text
        departmentCollection.forEach{(button) in
    
            UIView.animate(withDuration: 0.25, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
        })
            
    }
        
       
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    //hide the kewyboard when the user press anywhere on the screen
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        
    }
    
    
}




    




    

  


 



