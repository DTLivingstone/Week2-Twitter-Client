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
    @IBOutlet weak var profile: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var user: User?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let user = self.user {
            self.userName.text = "\(user.name)"
            print("23 \(user.name)")
            self.location.text = "\(user.location)"
            print("25 \(user.location)")
        } else { print("\(user)") }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        API.shared.GETOAuthUser { (user) in
            print(user)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeButtonSelected(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
