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
    @IBOutlet weak var videoRank: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    
    
    var video: MusicVideos? {
        didSet {
            updateCell()
        }
    }
    
    
    func updateCell() {
        videoTitle.text = video?.name
        videoRank.text = "\(video!.rank)"
        videoImageView.image = UIImage(named: "imageNotAvailable")
    }
}
