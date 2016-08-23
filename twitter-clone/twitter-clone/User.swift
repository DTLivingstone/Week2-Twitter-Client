//
//  User.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/13/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import Foundation

class User {
    let name: String?
    let screenName: String
    let profileImage: String
    let location: String
    
    init?(json: [String : AnyObject]) {
        if let name = json["name"] as? String, screenName = json["screen_name"] as? String, profileImage = json["profile_image_url"] as? String, location = json["location"] as? String {
            self.name = name
            self.screenName = screenName
            self.profileImage = profileImage
            self.location = location
            print("--------")
            print("\(name)")
            print("\(screenName)")

        } else {
            return nil
        }
    }
}