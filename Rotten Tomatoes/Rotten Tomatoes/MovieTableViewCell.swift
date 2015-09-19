//
//  MovieTableViewCell.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/15/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit
import AFNetworking

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieCoverImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var movieCoverURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setMovieCover(imageURL: String) {
        self.movieCoverImageView?.setImageWithURL(NSURL(string: imageURL)!)
    }
}


