//
//  RTAPISupport.swift
//  Rotten Tomatoes
//
//  Created by admin on 9/16/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit
import AFNetworking

struct RTDataConstants {
    static let movies = "movies"
    static let title = "title"
    static let movieCover = "posters"
    static let movieCoverOriginal = "original"
    static let synopsis = "synopsis"
    static let ratings = "ratings"
    static let audienceScore = "audience_score"
    static let criticsScore = "critics_score"
}

class RTAPISupport : NSObject {
    
    class func retrieveRTData(typeOfData: MovieTableViewController.DataType, successCallbackBlock: NSArray? -> Void, failureCallbackBlock: NSError? -> Void) {
        var url = "";
        switch typeOfData {
        case MovieTableViewController.DataType.BoxOffice:
            url = "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"
//            url = "http://localhost:8000/boxoffice.json"
        case MovieTableViewController.DataType.DVD:
            url = "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json"
//            url = "http://localhost:8000/dvd.json"
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
    
    class func getMovieTitle(data: NSDictionary) -> String? {
        if let title = data[RTDataConstants.title] as? String {
            return title
        }
        return nil
    }
    
    class func getMovieRatings(data:NSDictionary) -> String? {
        var ratingsText = ""
        if let ratings = data[RTDataConstants.ratings] as? NSDictionary {
            if let audience = ratings[RTDataConstants.audienceScore] as? Int {
                ratingsText =  ratingsText + "Audience Score: \(audience) "
            }
            if let critics = ratings[RTDataConstants.criticsScore] as? Int {
                ratingsText = ratingsText + "Critics Score: \(critics)";
            }
        }
        return ratingsText
    }
    
    class func getMovieSynopsis(data: NSDictionary) -> String? {
        if let description = data[RTDataConstants.synopsis] as? String {
            return description;
        }
        return nil
    }
    
    class func getMovieThumbnailImageURL(data: NSDictionary) -> String? {
        if let coverURL = data[RTDataConstants.movieCover] as? NSDictionary {
            if let url = coverURL[RTDataConstants.movieCoverOriginal] as? String {
                return url
            }
        }
        return nil
    }
    
    class func getMovieBigImageURL(data: NSDictionary) -> String? {
        let thumbnailURL = getMovieThumbnailImageURL(data);
        if (thumbnailURL != nil) {
            var url = thumbnailURL!
            let range = url.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
            if let range = range {
                url = url.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
            }
            return url;
        }
        return nil;
    }
    
    class func setMovieCover(imageView: UIImageView, movieData: NSDictionary) {
        if let url = RTAPISupport.getMovieThumbnailImageURL(movieData) {
            let request = NSURLRequest(URL: NSURL(string: url)!, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 216000) // Cache for a day
            imageView.setImageWithURLRequest(request, placeholderImage: UIImage(named: "noposter"), success: { (request, response, image) -> Void in
                imageView.image = image;
                if let bigURL = RTAPISupport.getMovieBigImageURL(movieData) {
                    imageView.setImageWithURL(NSURL(string: bigURL)!)
                }
                }, failure: nil)
        }
    }
}