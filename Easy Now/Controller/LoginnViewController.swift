//
//  LoginnViewController.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 22/10/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import VirgilSDK
import VirgilE3Kit

class LoginnViewController: UIViewController {
   
    
    var users = [User]()
    var oldMessagesController: OldMessagesController!
   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func needAnAccount(sender: AnyObject) {
        self.performSegue(withIdentifier: "registerpage", sender: self)
    }
    
    // Virgil-Firebase function URL
//    let jwtEndpointURL = URL(string: "https://us-central1-easynow-p5.cloudfunctions.net/api.cloudfunctions.net/api///virgil-jwt")!
//    let headers = ["Content-Type": "application/json",
//                   "Authorization": "Bearer " + firebaseToken]
//     //Callback function to retrieve JWT token from Firebase function
//   let tokenCallback: EThree.RenewJwtCallback = { completion in
//        let connection = HttpConnection()
//    let request = Request(url: jwtEndpointURL,
//                          method: .get,
//                          headers: headers)
//
//        guard let jwtResponse = try? connection.send(request),
//            let responseBody = jwtResponse.body,
//            let json = try? JSONSerialization.jsonObject(with: responseBody, options: []) as? [String: Any],
//            let jwtStr = json?["token"] as? String else {
//                completion(nil, AppError.gettingJwtFailed)
//                return
//        }
//
//        completion(jwtStr, nil)
//    }
    
    // Initialize EThree SDK with JWT token from Firebase Function
//    EThree.initialize(tokenCallback) { (eThree, error) in
//    if error == nil
//    print("It worked")
//    }
//    
    
    @IBAction func Login(_ sender: Any) {
    
    
    Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
    if error == nil{
    self.performSegue(withIdentifier: "mainpage", sender: self)
       
    }
    else{
    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    
    alertController.addAction(defaultAction)
    self.present(alertController, animated: true, completion: nil)
    }
        
      self.oldMessagesController?.specificMessages()
    }
    
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if let user = user {
//
//                EThree.initialize(tokenCallback: tokenCallback) { eThree, error in
//
//                   // Bootstrap user
//                   eThree.bootstrap(password: password) { error in
//
//                         //User private key loaded, ready to end-to-end encrypt!
//                      //  (The SDK works with Firebase UIDs)
//                       let usersToEncryptTo = [User]
//
//                        // Lookup destination user public keys
//                        eThree.lookupPublicKeys(of: usersToEncryptTo) { foundKeys, errors in
//                            guard errors.isEmpty else {
//                                // Error handling here
//                            }
//
       func viewDidLoad() {
        super.viewDidLoad()

      
        
        
       
    }

}
//                    }
//               }
//
//            }
//

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
}
}
//    }
//
//}
