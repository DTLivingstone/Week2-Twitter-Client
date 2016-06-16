//
//  Identity.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/15/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import Foundation

protocol Identity {
    static func id() -> String
}

extension Identity {
    static func id() -> String {
        return String(self)
    }
}

