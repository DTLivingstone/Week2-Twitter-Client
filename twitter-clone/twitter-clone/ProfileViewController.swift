//
//  ProfileViewController.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/16/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var location: UILabel!
    
    var loggedInUser: User?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        API.shared.GETOAuthUser { (user) in
            self.loggedInUser = user
              NSOperationQueue.mainQueue().addOperationWithBlock({
                self.userName.text = self.loggedInUser?.name
                self.location.text = self.loggedInUser?.location
                print("\(self.loggedInUser?.profileImage)")
                if let url = NSURL(string: (self.loggedInUser?.profileImage)!)
                {
                    let data = NSData(contentsOfURL: url)
                    print("\(data)")
//                    if let foo = UIImage(data: data!) {
//                        print("\(data)")
//                        self.profileImage.image = nil
//                    }
                }
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeButtonSelected(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
