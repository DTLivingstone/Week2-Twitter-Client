//
//  ProfileViewController.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/16/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        API.shared.GETOAuthUser { (user) in
            print(user)
        }
    }
    
    @IBAction func closeButtonSelected(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
