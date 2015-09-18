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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.registerClass(MovieTableViewCell.self, forCellReuseIdentifier: "cell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath);
        cell.textLabel?.text = "blah \(indexPath.row)";
        return cell;
    }
    
    func setRTDataType(type: DataType) {
        self.dataType = type;
    }
}

