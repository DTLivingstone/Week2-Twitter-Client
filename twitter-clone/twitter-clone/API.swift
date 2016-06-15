//
//  API.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/14/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import Foundation
import Social
import Accounts

class API {

    static let shared = API()
    var account: ACAccount?
    
    private func login(completion: (account: ACAccount?) -> ()) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: { (granted, error) -> Void in
        
        if let _ = error {
            print("unable to request access to account")
            completion(account: nil)
            return
        }
        
        if granted {
            if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                completion(account: account)
                return
            }
            
            print("no Twitter accounts found on this device")
            completion(account: nil)
            return
        }
        
        print("this app must have access to a Twitter account")
        completion(account: nil)
        return
        })
    }
    
    private func GETOAuthUser(completion: (user: User?) -> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod:.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error {
                print("could not complete SLRequest for account credentials")
                completion(user: nil)
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject] {
                        completion(user: User(json: userJSON))
                    }
                } catch {
                    print("could not serialize JSON")
                    completion(user: nil)
                }
                
            case 400...499:
                print("client error status code: \(response.statusCode)")
                completion(user: nil)
            case 500...599:
                print("server error status code: \(response.statusCode)")
                completion(user: nil)
            default:
                print("error status code")
                completion(user: nil)
            }
        }
    }
    
    private func updateTimeline(completion: (tweets: [Tweet]?) -> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error{
                print("could not complete SLRequest for user timeline")
                completion(tweets: nil)
                return
            }
            
            switch response.statusCode {
            case 200...299:
                JSONParser.tweetJSONFrom(data, completion: { (success, tweets) in
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(tweets: tweets)
                    })
                })
                
            case 400...499:
                print("client error status code: \(response.statusCode)")
                completion(tweets: nil)
            case 500...599:
                print("server error status code: \(response.statusCode)")
                completion(tweets: nil)
            default:
                print("error status code")
                completion(tweets: nil)
            }
        }
    }

    
}

