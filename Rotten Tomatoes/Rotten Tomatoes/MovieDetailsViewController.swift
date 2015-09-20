//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/18/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movieCoverURL: String?
    var movieDetails: String?
    var movieData: NSDictionary?
    
    @IBOutlet weak var movieCoverView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.movieCoverView.setImageWithURL(NSURL(string: self.getBigPictureURL(self.movieCoverURL!))!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getBigPictureURL(miniURL: String) -> String {
        var url = miniURL;
        let range = url.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            url = url.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        return url
    }
}
