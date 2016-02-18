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

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the Reachabililty Observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: NOTIFICATION_REACHABILITY_STATUS_CHANGED, object: nil)
        displayLabel.text = ""
        reachabilityStatusChanged()
        
        // Call the API Manager
        let api = APIManager()
        api.loadData(iTunesTopMusicVideos, completion: didLoadData)
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable via WiFi"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable via Cellular"
        default: return
        }
    }
    
    
    func didLoadData(videos: [MusicVideos]) {
        print(reachabilityStatus)
        
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
    
    
    // Remove the observer when the ViewController is deallocated
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_REACHABILITY_STATUS_CHANGED, object: nil)
    }
}

