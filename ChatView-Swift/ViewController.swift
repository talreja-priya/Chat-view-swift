//
//  ViewController.swift
//  ChatView-Swift
//
//  Created by Priya Talreja on 28/04/16.
//  Copyright © 2016 Priya Talreja. All rights reserved.
//

import UIKit
var messagesize :CGSize=CGSize()

var messages = [String]();
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var msgTxt: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messages=["Hi","Hello","How r yu","Fine","Good"]

        
        let bounds: CGRect = UIScreen.main.bounds
        let height:CGFloat = bounds.size.height
        tableHeight.constant = height - (65+43)
        self.tableView.updateConstraintsIfNeeded()
        
        self.registerForKeyboardNotifications()
        
        self.scrollToBottom()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "messaging"
    
       let cell = MessagingCell.init(style: .default, reuseIdentifier: cellIdentifier)
        
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    
    func configureCell(_ cell: AnyObject, atIndexPath indexPath: IndexPath) {
        let ccell: MessagingCell = (cell as! MessagingCell)
        if indexPath.row % 2 == 0 {
            ccell.sentBy = true
            ccell.profileImage.image = UIImage(named: "woman")
        }
        else {
            ccell.sentBy = false
            ccell.profileImage.image = UIImage(named: "man")
        }
        ccell.messageText.text = messages[indexPath.row]
        
        ccell.messageTime.text = self.formatDate(Date())
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ccell: MessagingCell = MessagingCell()
        messagesize = ccell.messageSize1(messages[indexPath.row] as NSString)
        return messagesize.height + 2 * ccell.floatVertical() + 40.0
 
        
    }
    
    
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd' 'MMM' 'yyyy"
        let formattedDate: String = dateFormatter.string(from: date)
        return formattedDate
    }

    @IBAction func sendClicked(_ sender: AnyObject) {
        messages.append(self.msgTxt.text!)
        self.tableView.reloadData()
        self.msgTxt.text=""
        
        self.scrollToBottom()
        
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func keyboardWasShown(_ aNotification: Notification) {
        var info: [AnyHashable: Any] = aNotification.userInfo!

        let kbSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height;
        if !aRect.contains(self.msgTxt.frame.origin) {
            self.scrollView.scrollRectToVisible(self.msgTxt.frame, animated: true)
        }
    
    }
    func keyboardWillBeHidden(_ aNotification: Notification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    //TextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    //Scroll Tableview to Bottom
    func scrollToBottom() {
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: self.tableView.contentSize.height - self.tableView.bounds.size.height, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height), animated: true)
    }
   
}

