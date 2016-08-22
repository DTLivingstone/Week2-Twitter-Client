//
//  TimelineViewController.swift
//  twitter-clone
//
//  Created by David Livingstone on 8/19/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, Identity {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweet: Tweet?
    
    var tweets = [Tweet]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    func update(screenname: String) {
        
        API.shared.getUserTweets(screenname) { (tweets) in
            guard let tweets = tweets else { return}
            self.tweets = tweets
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user{
                
                self.navigationItem.title = originalUser.name
                self.update(originalUser.name!)
            }
            else {
                print("went here instead")
                self.navigationItem.title = user.name
                self.update(user.name!)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("I have \(self.tweets.count)")
        return self.tweets.count
    }
    
    func setupTableView()
    {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
        self.tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        tweetCell.tweet = self.tweets[indexPath.row]
        
        return tweetCell
        
    }
}
