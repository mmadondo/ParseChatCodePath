//
//  ChatViewController.swift
//  ParseChatCodePath
//
//  Created by Malvern Madondo on 12/2/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages: [PFObject]?
    
    @IBOutlet weak var chatMessageTextField: UITextField!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    
    @IBAction func onTapSendBtn(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        
        // Store text entered in text field into the object
        chatMessage["text"] = chatMessageTextField.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageTextField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chatTableView.delegate = self;
        chatTableView.dataSource = self;
        
        // Auto size row height based on cell autolayout constraints
        //tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        //tableView.estimatedRowHeight = 50

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true) // a refresh function that is run every second.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        if let messages = messages {
            let message = messages[indexPath.row]
           cell.chatMessage.text = message["text"] as! String
            if let user = message["user"] as? PFUser {
                // User found! update username label with username
                cell.userNameLabel.text = user.username
            } else {
                // No user found, set default username
               cell.userNameLabel.text  = "🤖"
            }
            
        }
        return cell
    }
    
    @objc func refresh() {
        // construct PFQuery
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        
        // fetch data asynchronously
        
        query.findObjectsInBackground{ (messages: [PFObject]?, error: Error?) -> Void in
            if let messages = messages {
                self.messages = messages
                self.chatTableView.reloadData();
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
