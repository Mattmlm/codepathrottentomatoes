//
//  MovieTableViewController.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/14/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit
import MBProgressHUD

class MovieTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum DataType: Int {
        case BoxOffice = 0, DVD
    }
    
    var dataType: DataType?
    var movies: NSArray?
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.movies = NSArray()
        
        self.movieTableView.delegate = self;
        self.movieTableView.dataSource = self;
        
        self.refreshControl.addTarget(self, action: "onRefresh", forControlEvents: .ValueChanged)
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.movieTableView.insertSubview(self.refreshControl, atIndex: 0)
        self.loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.movies != nil) {
            return self.movies!.count
        } else {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Movie Cell", forIndexPath: indexPath);
        if let movieCell = cell as? MovieTableViewCell {
            if let movie = self.movies![indexPath.row] as? NSDictionary {
                if let title = RTAPISupport.getMovieTitle(movie) {
                    movieCell.movieTitleLabel.text = title
                }
                if let url = RTAPISupport.getMovieBigImageURL(movie) {
                    movieCell.setMovieCover(url);
                }
                if let description = RTAPISupport.getMovieSynopsis(movie) {
                    movieCell.movieDescriptionLabel.text = description;
                }
            }
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
    func setRTDataType(type: DataType) {
        self.dataType = type;
    }
    
    func loadMovies() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true);
        RTAPISupport.retrieveRTData(self.dataType!, successCallbackBlock: { (movies) -> Void in
            self.errorView.hidden = true;
            MBProgressHUD.hideHUDForView(self.view, animated: true);
            if (movies != nil) {
                self.movies = movies!
                self.movieTableView.reloadData();
            } else {
                self.movies = []
            }
            }) { (error) -> Void in
                self.errorView.hidden = false;
                MBProgressHUD.hideHUDForView(self.view, animated: true);
        }
    }
    
    func onRefresh() {
        RTAPISupport.retrieveRTData(self.dataType!, successCallbackBlock: { (movies) -> Void in
            self.errorView.hidden = true;
            MBProgressHUD.hideHUDForView(self.view, animated: true);
            if (movies != nil) {
                self.movies = movies!
                self.movieTableView.reloadData();
            } else {
                self.movies = []
            }
            self.refreshControl.endRefreshing()
            }) { (error) -> Void in
                self.errorView.hidden = false;
                self.refreshControl.endRefreshing()
        }
    }
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // If segue is for movie cells
        if (segue.identifier == "showMovieDetails") {
            if let movieDetailsVC = segue.destinationViewController as? MovieDetailsViewController {
                if let movieData = self.movies?[(self.movieTableView.indexPathForSelectedRow?.row)!] as? NSDictionary {
                    movieDetailsVC.movieData = movieData;
                }
            }
        }
    }
}

