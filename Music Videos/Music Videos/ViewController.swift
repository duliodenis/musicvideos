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
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: "No Internet Access", message: "Please ensure you have a connection to the internet.", preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: "OK", style: .Default) { action -> () in
                    print("OK")
                }
                
                alert.addAction(okAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                self.displayLabel.text = "No Internet"
            }
            
        default:
            view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Internet Access"
            if musicVideos.count == 0 {
                callAPI()
            } else {
                print("No refresh required")
            }
        }
    }
    
    
    func didLoadData(videos: [MusicVideos]) {
        musicVideos = videos
        tableView.reloadData()
    }
    
    
    func callAPI() {
        // Call the API Manager
        let api = APIManager()
        api.loadData(iTunesTopMusicVideos, completion: didLoadData)
    }
    
    
    // Remove the observer when the ViewController is deallocated
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_REACHABILITY_STATUS_CHANGED, object: nil)
    }
    
    
    // MARK: Table View Delegate Methods
    
    private struct storyboard {
        static let cellReuseIdentifier = "cell"
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicVideos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        cell.video = musicVideos[indexPath.row]

        return cell
    }
}

