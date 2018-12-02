//
//  UserCell.swift
//  Easy Now
//
//  Created by Irina Ioana Avadanei on 21/11/2018.
//  Copyright © 2018 Irina Ioana Avadanei. All rights reserved.
//

import UIKit
import Firebase

class UserCell: UITableViewCell {
    
    
    
    var message: Message? {
        didSet {
           
            setUpName()
            self.detailTextLabel?.text = message?.text
            
            
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
              timeLabel.text = dateFormatter.string(from: timestampDate)
            }
            
            
        }
    }
    
    private func setUpName(){
        
       // let chatPartnerId: String?
        
       // if message?.fromId == Auth.auth().currentUser?.uid {
       //     chatPartnerId = message?.toId
      //  } else {
      //      chatPartnerId = message?.fromId
     //   }
        
        
        if let id = message?.chatPartnerId() {
            let ref = Database.database().reference().child("users").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.textLabel?.text = dictionary["Username"] as? String
                    
                    
                }
                
            }, withCancel: nil)
        }
    }
   
   
     let timeLabel: UILabel = {
        let label = UILabel()
        //label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
  
        
       addSubview(timeLabel)
        
        //ios 9 constraint anchors
      
        
        //need x,y,width,height anchors
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: textLabel!.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
  
           // super.init(coder: aDecoder)
        
    }
}
    

