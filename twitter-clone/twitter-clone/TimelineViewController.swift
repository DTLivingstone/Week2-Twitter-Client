//
//  TimelineViewController.swift
//  twitter-clone
//
//  Created by David Livingstone on 8/19/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, Identity {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweet: Tweet?
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user {
                print("retweet")
                self.navigationItem.title = originalUser.name
                self.update(originalUser.name!)
            } else {
                print("original content")
                self.navigationItem.title = user.name
                self.update(user.name!)
            }
        }
    }
    
    func update(screenname: String) {
        API.shared.getUserTweets(screenname) { (tweets) in
            guard let tweets = tweets else { return}
            self.datasource = tweets
        }
    }
    
    func setupTableView()
    {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet = self.datasource[indexPath.row]
        cell.tweet = tweet
        
        return cell
    }
}