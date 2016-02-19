//
//  ViewController.swift
//  Music Videos
//
//  Created by Dulio Denis on 2/14/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var musicVideos = [MusicVideos]()

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
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
        musicVideos = videos
        tableView.reloadData()
    }
    
    
    // Remove the observer when the ViewController is deallocated
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_REACHABILITY_STATUS_CHANGED, object: nil)
    }
    
    
    // MARK: Table View Delegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicVideos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let musicVideo = musicVideos[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1)"
        cell.detailTextLabel?.text = musicVideo.name

        return cell
    }
}

