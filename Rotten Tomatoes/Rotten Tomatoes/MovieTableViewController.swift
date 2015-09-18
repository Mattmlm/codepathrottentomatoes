//
//  ViewController.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/14/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    enum DataType: Int {
        case BoxOffice = 0, DVD
    }
    
    var dataType: DataType?
    var movies: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.movies = NSArray()
        
        tableView.registerClass(MovieTableViewCell.self, forCellReuseIdentifier: "cell");
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "onRefresh", forControlEvents: .ValueChanged)
        self.tableView.insertSubview(self.refreshControl!, atIndex: 0)
        
        self.loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.movies != nil) {
            return self.movies!.count
        } else {
            return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath);
        
        if let movie = self.movies![indexPath.row] as? NSDictionary {
            if let title = movie[RTDataConstants.title] as? String {
                cell.textLabel?.text = title
            }
        }
        
        return cell;
    }
    
    func setRTDataType(type: DataType) {
        self.dataType = type;
    }
    
    func loadMovies() {
        RTAPISupport.retrieveRTData(self.dataType!, successCallbackBlock: { (movies) -> Void in
            if (movies != nil) {
                self.movies = movies!
                self.tableView.reloadData();
            } else {
                self.movies = []
            }
            self.refreshControl?.endRefreshing()
            }) { (error) -> Void in
                self.refreshControl?.endRefreshing()
        }
    }
    
    func onRefresh() {
        self.loadMovies();
    }
}

