//
//  MusicVideoTableViewCell.swift
//  Music Videos
//
//  Created by Dulio Denis on 2/20/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoArtist: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    
    
    var video: MusicVideos? {
        didSet {
            updateCell()
        }
    }
    
    
    func updateCell() {
        // Use Preferred for for Accessibility
        videoTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        videoArtist.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        videoTitle.text = video?.name
        videoArtist.text = video?.artist
        
        if video!.imageData != nil {
            // get data from array
            videoImageView.image = UIImage(data: video!.imageData!)
        } else {
            getVideoImages(video!, imageView: videoImageView)
        }
    }
    
    
    func getVideoImages(video: MusicVideos, imageView: UIImageView) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: video.imageURL)!)
            
            var image: UIImage?
            
            if data != nil {
                video.imageData = data
                image = UIImage(data: data!)
            }
            
            // back to the main queue
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
}
