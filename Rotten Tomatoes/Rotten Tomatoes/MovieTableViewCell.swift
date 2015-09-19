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
    
    override func prepareForReuse() {
        self.movieCoverImageView.image = nil;
        super.prepareForReuse()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setMovieCover(imageURL: String) {
        var url = imageURL;
        let range = url.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            url = url.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        self.movieCoverImageView?.setImageWithURL(NSURL(string: url)!)
    }
}


