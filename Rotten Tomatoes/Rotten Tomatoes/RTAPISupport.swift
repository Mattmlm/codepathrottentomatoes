//
//  RTAPISupport.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/16/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit
import AFNetworking

class RTAPISupport : NSObject {
    
    class func retrieveRTData(typeOfData: MovieTableViewController.DataType, successCallbackBlock: NSArray? -> Void, failureCallbackBlock: NSError? -> Void) {
        var url = "";
        switch typeOfData {
        case MovieTableViewController.DataType.BoxOffice:
            url = "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"
        case MovieTableViewController.DataType.DVD:
            url = "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json"
        default:
            url = "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"
        }
        
        let request = NSURLRequest(URL: NSURL(string: url)!);
        let operation = AFHTTPRequestOperation(request: request);
        operation.setCompletionBlockWithSuccess({ (AFOperation: AFHTTPRequestOperation, response: AnyObject) -> Void in
            if let data = response as? NSData {
                dispatch_async(dispatch_get_main_queue()) {
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary {
                            // extract movies from JSON here and assign it to class variable
                            print(json)
                            if let movies = json[RTDataConstants.movies] as? NSArray {
                                successCallbackBlock(movies)
                            } else {
                                successCallbackBlock(nil)
                            }
                        }
                        
                    } catch {
                        print("Could not unwrap JSON. DOH!")
                        failureCallbackBlock(nil)
                    }
                }
            }
        }) { (AFOperation: AFHTTPRequestOperation , error: NSError) -> Void in
                print(error)
                failureCallbackBlock(error)
        }
        operation.start();
    }
}