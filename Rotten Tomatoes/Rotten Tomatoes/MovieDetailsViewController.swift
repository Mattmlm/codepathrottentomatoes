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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.movieData != nil {
            if let url = RTAPISupport.getMovieBigImageURL(self.movieData!) {
                self.movieCoverView.setImageWithURL(NSURL(string: url)!)
            }
            if let title = RTAPISupport.getMovieTitle(self.movieData!) {
                self.movieTitleLabel.text = title;
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
