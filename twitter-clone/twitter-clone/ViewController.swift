//
//  ViewController.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/13/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.navigationItem.title = "Twitterpated"
        let tweetCell = UINib(nibName: "tweetCell", bundle: nil)
        tableView.registerNib(tweetCell, forCellReuseIdentifier: "tweetCell")
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.update()
    }
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 800
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func update(){
        API.shared.getMyTweets { (tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailViewController.id() {
            guard let detailViewController = segue.destinationViewController as? DetailViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            print(indexPath)
            detailViewController.tweet = self.datasource[indexPath.row]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDataSource {
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