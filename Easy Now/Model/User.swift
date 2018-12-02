//
//  User.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 18/11/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit

class User: NSObject {
 //in this class we are saving the user references that will be displayes under the name in the tableview
     @objc var id: String?
     @objc var Username: String?
     @objc var department: String?
     @objc var email: String?
   
    init(dictionary: [String: AnyObject]) {
        self.Username = dictionary["Username"] as? String
        self.email = dictionary["email"] as? String
        self.department = dictionary["department"] as? String
        self.id = dictionary["id"] as? String
        
    }
}


