//
//  MusicVideoDetailViewController.swift
//  Music Videos
//
//  Created by Dulio Denis on 2/21/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class MusicVideoDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var musicVideo: MusicVideos!
    
    override func viewDidLoad() {
        // set the Navigation Back Button
        setBackButton()
        
        nameLabel.text = musicVideo.name
        title = musicVideo.artist
        
        if musicVideo.imageData != nil {
            imageView.image = UIImage(data: musicVideo.imageData!)
        } else {
            imageView.image = UIImage(named: "imageNotAvailable")
        }
    }
    
    func setBackButton() {
        let backButton = UIButton(type: UIButtonType.Custom)
        backButton.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("< Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        backButton.sizeToFit()
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonItem
    }
    
    func goBack(sender:UIBarButtonItem){
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
