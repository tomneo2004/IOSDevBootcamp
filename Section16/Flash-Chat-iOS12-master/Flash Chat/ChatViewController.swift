//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // Declare instance variables here
    var messageArray : [Message] = []
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.dataSource  = self
        messageTableView.delegate = self
        
        
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self
        
        
        //TODO: Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        

        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retrieveMessages()
        
        messageTableView.separatorStyle = .none
    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        let message = messageArray[indexPath.row]
        cell.messageBody.text = message.body
        cell.senderUsername.text = message.sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email{
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatSand()
        }
        else{
            cell.avatarImageView.backgroundColor = UIColor.flatGreen()
            cell.messageBackground.backgroundColor = UIColor.flatBlue()
        }
        
        return cell
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped(){
        messageTextfield.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here:
    func configureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendPressed(messageTextfield)
        return true
    }
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        UIView.animate(withDuration: 0.5) {
//
//            self.heightConstraint.constant = 308
//            self.view.layoutIfNeeded()
//        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustTextField(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustTextField(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        UIView.animate(withDuration: 0.5) {
//
//            self.heightConstraint.constant = 50
//            self.view.layoutIfNeeded()
//        }
        
    }

    @objc func adjustTextField(notification : Notification){
        
        if notification.name == UIResponder.keyboardWillHideNotification{
            UIView.animate(withDuration: 0.5) {

                self.heightConstraint.constant = 50
                self.view.layoutIfNeeded()
            }
            
            return
        }
        
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRect = frame.cgRectValue
            var height = keyboardRect.height
            
            if #available(iOS 11.0, *) {
                height -= view.safeAreaInsets.bottom
            }
            
            UIView.animate(withDuration: 0.5) {
                
                self.heightConstraint.constant = CGFloat(50 + height)
                self.view.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.heightConstraint.constant = CGFloat(50 + height)
                self.view.layoutIfNeeded()
                
            }) { (complete) in
                
                if complete{
                    
                    self.messageTableView.scrollToRow(at: IndexPath(row: self.messageArray.count-1, section: 0), at: .bottom, animated: true)
                }
            }
        }
    }
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        
        let messageDic = ["Sender":Auth.auth().currentUser?.email,"MessageBody":messageTextfield.text!]
        
        messageDB.childByAutoId().setValue(messageDic){
            (error, reference) in
            
            if error != nil{
             
                print(error!)
            }
            else{
                print("Message save successful")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
    }
    
    //TODO: Create the retrieveMessages method here:
    func retrieveMessages(){
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapShot) in
            
            let snapshotValue = snapShot.value as! Dictionary<String, String>
            
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.body = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            //self.configureTableView()
            self.messageTableView.reloadData()
            
            self.messageTableView.scrollToRow(at: IndexPath(row: self.messageArray.count-1, section: 0), at: .bottom, animated: true)
        }
    }
    

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do{
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
        }
        catch{
            print("Error, there is an error while sigining out")
        }
        
    }
    


}
