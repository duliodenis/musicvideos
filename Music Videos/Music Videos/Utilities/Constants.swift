//
//  Constants.swift
//  Music Videos
//
//  Created by Dulio Denis on 2/15/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

typealias JSONArray = Array<AnyObject>

let iTunesTopMusicVideos = "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json"


// Reachability Constants

let WIFI = "WIFI Available"

let NOACCESS = "No Internet Access"

let WWAN = "Cellular Access Available"

let NOTIFICATION_REACHABILITY_STATUS_CHANGED = "ReachabilityStatusChanged"