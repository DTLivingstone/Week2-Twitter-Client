//
//  DetailViewController.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/15/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            if let retweet = tweet.retweet {
                self.tweetLabel.text = retweet.text
                self.username.text = retweet.user?.name
            }
                
            else {
                self.tweetLabel.text = tweet.text
                self.username.text = tweet.user?.name
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
