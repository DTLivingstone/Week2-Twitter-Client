//
//  JSONParser.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/13/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()

class JSONParser {
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion) {
        
    }
    class func JSONData() -> NSData {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "JSON") else { fatalError("JSON does not exit") }
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else { fatalError("JSON does not exist") }
        return tweetJSONData
    }
}