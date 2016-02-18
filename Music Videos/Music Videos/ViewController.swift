//
//  ViewController.swift
//  Music Videos
//
//  Created by Dulio Denis on 2/14/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var musicVideos = [MusicVideos]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the API Manager
        let api = APIManager()
        api.loadData(iTunesTopMusicVideos, completion: didLoadData)
    }
    
    
    func didLoadData(videos: [MusicVideos]) {
        musicVideos = videos
        
        var videoList: String = ""
        
        for video in musicVideos {
            print("\(video.name)")
            videoList += "\(video.name), "
        }
        
        let alert = UIAlertController(title: "Top \(videos.count) Music Videos", message: "\(videoList)", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            // do something
        }
        
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
}

