//
//  AppDelegate.swift
//  Music Videos
//
//  Created by Dulio Denis on 2/14/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

// Reachability Variables
var reachability: Reachability?
var reachabilityStatus = ""


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var internetCheck: Reachability?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Add an observer for reachability
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
        
        // check to see if the default route is available
        internetCheck = Reachability.reachabilityForInternetConnection()
        // start listening for reachability notifications
        internetCheck?.startNotifier()
        // get current status of reachability
        statusChangedWithReachability(internetCheck!)
        
        return true
    }

    
    func reachabilityChanged(notification: NSNotification) {
        reachability = notification.object as? Reachability
        statusChangedWithReachability(reachability!)
    }
    
    
    func statusChangedWithReachability(reachability: Reachability) {
        let networkStatus: NetworkStatus = reachability.currentReachabilityStatus()
        
        switch networkStatus.rawValue {
        case NotReachable.rawValue: reachabilityStatus = NOACCESS
        case ReachableViaWiFi.rawValue: reachabilityStatus = WIFI
        case ReachableViaWWAN.rawValue: reachabilityStatus = WWAN
        default: return
        }
        
        // Post a Notification
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_REACHABILITY_STATUS_CHANGED, object: nil)
    }
    
    
    // Remove the observer when the app terminates
    func applicationWillTerminate(application: UIApplication) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil)
    }
}

