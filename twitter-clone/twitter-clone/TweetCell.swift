//
//  TweetCell.swift
//  twitter-clone
//
//  Created by David Livingstone on 8/19/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            print("\(tweet.text)")
            print("\(self.tweetLabel).text")
            
            self.tweetLabel.text = tweet.text
            
            if let user = self.tweet.user {
                self.userNameLabel.text = user.name
            
                guard let imageURL = NSURL(string: user.profileImage) else { return }
                guard let imageData = NSData(contentsOfURL: imageURL) else { return }
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    print("\(imageData)")
                    self.userImageView.image = UIImage(data: imageData)
                })
            }
        }
    }
    
    func setupTweetCell() {
        self.userImageView.clipsToBounds = true
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
        self.layoutMargins = UIEdgeInsetsZero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTweetCell()
    }
}

