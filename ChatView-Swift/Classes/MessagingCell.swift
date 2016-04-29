//
//  MessagingCell.swift
//  ChatView-Swift
//
//  Created by Priya Talreja on 28/04/16.
//  Copyright © 2016 Priya Talreja. All rights reserved.
//

import UIKit


 class MessagingCell: UITableViewCell {
    var msgView: UIView!
    var msgBalView: UIImageView!
    
    var profileImage: UIImageView!=UIImageView()
    var messageTime: UILabel!=UILabel()
    
    var messageText: UILabel!=UILabel()
    var sentBy: Bool!=Bool()
    var textMarginHorizontal: CGFloat = 15.5
    var textMarginVertical: CGFloat = 7.5
    var messageTextSize: CGFloat = 14.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    class func maxTextWidth() -> CGFloat {
        if UI_USER_INTERFACE_IDIOM() == .Phone {
            return 220.0
        }
        else {
            return 400.0
        }
    }
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func balloonImage(sent: Bool) -> UIImage {
        if sent == true {
            return MessagingCell.imageWithColor(UIColor(red: 200/255, green: 230/255, blue: 201/255, alpha: 1.0));
            
        }
        else {
            return MessagingCell.imageWithColor(UIColor(red: 232/255, green: 245/255, blue: 233/255, alpha: 1.0));
        }
        
        
    }
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        
        self.msgView = UIView(frame: CGRectZero)
        self.msgView.autoresizingMask = .FlexibleHeight
        self.msgBalView = UIImageView(frame: CGRectZero)
        self.messageText = UILabel(frame: CGRectZero)
        self.messageTime = UILabel(frame: CGRectZero)
        self.profileImage = UIImageView(image: nil)
        self.messageText.backgroundColor = UIColor.clearColor()
        self.messageText.font = UIFont.systemFontOfSize(messageTextSize)
        self.messageText.lineBreakMode = .ByWordWrapping
        self.messageText.numberOfLines = 0
        self.messageTime.font = UIFont.boldSystemFontOfSize(10.0)
        self.messageTime.textColor = UIColor.darkGrayColor()
        self.messageTime.backgroundColor = UIColor.clearColor()
        self.msgView.addSubview(self.msgBalView)
        self.msgView.addSubview(self.messageText)
        self.contentView .addSubview(self.messageTime)
        self.contentView .addSubview(self.msgView)
        self.contentView .addSubview(self.profileImage)

    }
   
    
    
    required  init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func floatVertical () -> CGFloat  {
        return textMarginVertical
    }
    func floatHorizontal () -> CGFloat  {
        return textMarginHorizontal
    }
    func messageSize1(message: NSString) -> CGSize {
        
        let a=message.boundingRectWithSize(CGSizeMake(MessagingCell.maxTextWidth(), CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName :messageText.font], context: nil)

        return a.size
    }
    override func layoutSubviews() {
        let textSize: CGSize = self.messageSize1(messageText.text!)
        
        
        let b=messageTime.text!._bridgeToObjectiveC().boundingRectWithSize(messageTime.frame.size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName :messageTime.font], context: nil)
        let timeSize: CGSize = b.size
        
        var msgBalViewFrame: CGRect = CGRectZero
        var messageTextFrame: CGRect = CGRectZero
        var messageTimeFrame: CGRect = CGRectZero
        var profileImageFrame: CGRect = CGRectZero
        
        
        if sentBy == true {
            messageTimeFrame = CGRectMake(self.frame.width-timeSize.width-textMarginHorizontal-39,0.0, timeSize.width, timeSize.height);

             msgBalViewFrame = CGRectMake(self.frame.size.width - 35 - (textSize.width + 2 * textMarginHorizontal), messageTimeFrame.size.height+2, textSize.width+2*textMarginHorizontal, textSize.height + 2 * textMarginVertical)
            messageTextFrame = CGRectMake(self.frame.size.width - 32 - (textSize.width + textMarginHorizontal), msgBalViewFrame.origin.y + textMarginVertical,textSize.width, textSize.height)
            profileImageFrame = CGRectMake(self.frame.size.width - 34, messageTimeFrame.size.height+msgBalViewFrame.height/2-timeSize.height, 32.0, 32.0)
            
            
        }
        else
        {
            messageTimeFrame = CGRectMake(textMarginHorizontal + 30, 0.0, timeSize.width, timeSize.height)
            msgBalViewFrame = CGRectMake(0.0 + 35, messageTimeFrame.size.height+2, textSize.width + 2 * self.textMarginHorizontal, textSize.height + 2 * self.textMarginVertical)
            messageTextFrame = CGRectMake(textMarginHorizontal + 32, msgBalViewFrame.origin.y + self.textMarginVertical, textSize.width, textSize.height)
            
            profileImageFrame = CGRectMake(4, messageTimeFrame.size.height+msgBalViewFrame.height/2-timeSize.height, 32.0, 32.0)
        }
        
        self.msgBalView.image = MessagingCell.balloonImage(sentBy)
        self.msgBalView.frame = msgBalViewFrame
        self.messageText.frame = messageTextFrame
        if self.profileImage.image != nil {
            self.profileImage.frame = profileImageFrame
            profileImage.layer.cornerRadius=profileImage.frame.size.width/2
            profileImage.layer.masksToBounds=true

        }
        
        if self.messageTime.text != nil {
            self.messageTime.frame = messageTimeFrame
        }
        
        

    }
    
        
        
}
