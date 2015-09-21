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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieCoverImageView.image = nil;
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setMovieCover(movieData: NSDictionary) {
        RTAPISupport.setMovieCover(self.movieCoverImageView, movieData: movieData);
    }
}


