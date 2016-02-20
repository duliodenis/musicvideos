//
//  MusicVideos.swift
//  Music Videos
//
//  Created by Dulio Denis on 2/16/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import Foundation

class MusicVideos {
    
    private var _name: String
    private var _imageURL: String
    private var _videoURL: String
    
    var rank = 0            // this variable is assigned in the API Manager
    var imageData: NSData?  // this variable gets created from the UI
    
    var name: String {
        return _name
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var videoURL: String {
        return _videoURL
    }

    
    // MARK: Initializer for Music Video Object
    
    init(data: JSONDictionary) {
        // Video Name
        if let videoNameDictionary = data["im:name"] as? JSONDictionary,
            videoName = videoNameDictionary["label"] as? String {
            _name = videoName
        } else { // in case we get nothing back from the JSON
            _name = ""
        }
        
        // Video Image
        if let imageArray = data["im:image"] as? JSONArray,
            imageDictionary = imageArray[2] as? JSONDictionary,
            imageLabel = imageDictionary["label"] as? String {
                _imageURL = imageLabel.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else { // in case we get nothing back from the JSON
            _imageURL = ""
        }
        
        // Video URL
        if let videoArray = data["link"] as? JSONArray,
            urlDictionary = videoArray[1] as? JSONDictionary,
            attributeDictionary = urlDictionary["attributes"] as? JSONDictionary,
            videoHref = attributeDictionary["href"] as? String {
                _videoURL = videoHref
        } else { // in case we get nothing back from the JSON
            _videoURL = ""
        }
    }
    
}