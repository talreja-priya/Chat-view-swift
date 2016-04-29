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

        
        let bounds: CGRect = UIScreen.mainScreen().bounds
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "messaging"
    
       let cell = MessagingCell.init(style: .Default, reuseIdentifier: cellIdentifier)
        
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    
    func configureCell(cell: AnyObject, atIndexPath indexPath: NSIndexPath) {
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
        
        ccell.messageTime.text = self.formatDate(NSDate())
       
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let ccell: MessagingCell = MessagingCell()
        messagesize = ccell.messageSize1(messages[indexPath.row])
        return messagesize.height + 2 * ccell.floatVertical() + 40.0
 
        
    }
    
    
    
    func formatDate(date: NSDate) -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.dateFormat = "dd' 'MMM' 'yyyy"
        let formattedDate: String = dateFormatter.stringFromDate(date)
        return formattedDate
    }

    @IBAction func sendClicked(sender: AnyObject) {
        messages.append(self.msgTxt.text!)
        self.tableView.reloadData()
        self.msgTxt.text=""
        
        self.scrollToBottom()
        
    }
    
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden(_:)), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardWasShown(aNotification: NSNotification) {
        var info: [NSObject : AnyObject] = aNotification.userInfo!

        let kbSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
        if !CGRectContainsPoint(aRect, self.msgTxt.frame.origin) {
            self.scrollView.scrollRectToVisible(self.msgTxt.frame, animated: true)
        }
    
    }
    func keyboardWillBeHidden(aNotification: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    //TextField Delegate Method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    //Scroll Tableview to Bottom
    func scrollToBottom() {
        self.tableView.scrollRectToVisible(CGRectMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height), animated: true)
    }
   
}

