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
    let profileImage: String
    let location: String
    let screenName: String
    
    init?(json: [String : AnyObject]) {
        if let name = json["name"] as? String, profileImage = json["profile_image_url"] as? String, location = json["location"] as? String, screenName = json["screen_name"] as? String {
            self.name = name
            self.profileImage = profileImage
            self.location = location
            self.screenName = screenName
        } else {
            return nil
        }
    }
}