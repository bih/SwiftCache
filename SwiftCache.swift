//
//  SwiftCache.swift
//  http://github.com/bih/SwiftCache
//
//  Created by Bilawal Hameed on 28/04/2015.
//  Copyright (c) 2015 Bilawal Hameed. All rights reserved.
//

import UIKit
import Foundation

class SwiftCache {
    var name : String
    var altName : String
    var expiresIn : Int
    var data : AnyObject
    var respond : (AnyObject) -> Void
    
    init(name : String, expiresIn: Int) {
        self.name = name
        self.altName = "\(name)-expires"
        self.expiresIn = expiresIn
        self.data = [[String: AnyObject]]()
        self.respond = { objectData in }
    }
    
    init(name : String) {
        self.name = name
        self.altName = "\(name)-expires"
        self.expiresIn = 60
        self.data = [[String: AnyObject]]()
        self.respond = { objectData in }
    }
    
    func request(callback: (SwiftCache) -> Void) -> SwiftCache {
        if isCached() {
            self.respond(gets())
        } else {
            callback(self)
        }
        
        return self
    }
    
    func respond(callback: (AnyObject) -> Void) -> SwiftCache {
        self.respond = callback
        return self
    }
    
    func expireCache() {
        NSUserDefaults().removeObjectForKey(self.altName)
        NSUserDefaults().removeObjectForKey(self.name)
    }
    
    private func gets() -> AnyObject {
        return NSUserDefaults().objectForKey(self.name)!
    }
    
    func saveToCache(json: [JSON]) -> SwiftCache {
        var convertedToObj = [[String : AnyObject]]()
        
        for (obj : JSON) in json {
            convertedToObj.append(obj.dictionaryObject!)
        }
        
        return saveToCache(convertedToObj)
    }
    
    func saveToCache(data: AnyObject) -> SwiftCache {
        self.data = data
        self.respond(data)
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.save()
        }
        
        return self
    }
    
    private func save() {
        // Save to cache
        NSUserDefaults().setObject(Int(NSDate().timeIntervalSince1970) + self.expiresIn, forKey: self.altName)
        NSUserDefaults().setObject(data, forKey: self.name)
    }
    
    func secondsLeftInCache() -> Int {
        if let cachedUntil = NSUserDefaults().integerForKey(self.altName) as? Int {
            return cachedUntil - Int(NSDate().timeIntervalSince1970)
        } else {
            return -1
        }
    }
    
    func isCached() -> Bool {
        return secondsLeftInCache() > 0
    }
}