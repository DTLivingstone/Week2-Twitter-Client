//
//  DetailViewController.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/15/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            if let retweet = tweet.retweet {
                // original poster's profile image
                
                guard let url = NSURL(string: (retweet.user?.profileImage)!) else { return }
                guard let imageData = NSData(contentsOfURL: url) else { return }
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.userImage.image = UIImage(data: imageData)
                })
                self.tweetLabel.text = retweet.text
                self.username.text = retweet.user?.name
                
            } else {
                
                // profile image
                
                guard let url = NSURL(string: (tweet.user?.profileImage)!) else { return }
                guard let imageData = NSData(contentsOfURL: url) else { return }
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.userImage.image = UIImage(data: imageData)
                })
                self.tweetLabel.text = tweet.text
                self.username.text = tweet.user?.name
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
