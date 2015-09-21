//
//  MovieTableViewCell.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/15/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieCoverImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieCoverImageView.image = nil;
        self.movieCoverImageView.alpha = 0.2;
        self.movieTitleLabel.text = "";
        self.movieDescriptionLabel.text = "";
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        UIView.animateWithDuration(1) { () -> Void in
            self.movieCoverImageView.alpha = 1;
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setMovieCover(movieData: NSDictionary) {
        RTAPISupport.setMovieCover(self.movieCoverImageView, movieData: movieData);
    }
}


