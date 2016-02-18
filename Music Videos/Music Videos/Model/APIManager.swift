//
//  APIManager.swift
//  Music Videos
//
//  Created by Dulio Denis on 2/15/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: (result: [MusicVideos]) -> Void) {
        
        // turn NSURLSession caching off
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            } else { // JSON Serialization
                do {
                    // .AllowFragments - top level object is not an Array or Dictionary
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray {
                            // make a MusicVideo array
                            var musicVideos = [MusicVideos]()
                            // and iterate through the JSON to gather the music video objects
                            for entry in entries {
                                let musicVideo = MusicVideos(data: entry as! JSONDictionary)
                                musicVideos.append(musicVideo)
                            }
                            
                            // and send the music video array back on the main queue
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(result: musicVideos)
                                }
                            }
                    }
                } catch {
                    print("error in NSJSONSerialization")
                }
            }
        }
        task.resume()
    }
}