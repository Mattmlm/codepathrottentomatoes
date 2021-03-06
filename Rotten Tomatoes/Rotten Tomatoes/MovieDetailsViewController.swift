//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/18/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieData: NSDictionary?

    @IBOutlet weak var movieCoverView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var movieRatingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()

        // Do any additional setup after loading the view.
        
        UIView.animateWithDuration(2) { () -> Void in
            self.movieCoverView.alpha = 1;
        }
        
        if self.movieData != nil {
            RTAPISupport.setMovieCover(self.movieCoverView, movieData: self.movieData!);
            if let title = RTAPISupport.getMovieTitle(self.movieData!) {
                self.movieTitleLabel.text = title;
                self.navigationItem.title = title;
            }
            if let ratings = RTAPISupport.getMovieRatings(self.movieData!) {
                self.movieRatingsLabel.text = ratings;
            }
            if let description = RTAPISupport.getMovieSynopsis(self.movieData!) {
                self.movieDetailsLabel.text = description;
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
