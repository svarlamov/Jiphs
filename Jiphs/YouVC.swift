//
//  YouVC.swift
//  Jiphs
//
//  Created by Stefan DeClerck on 5/24/15.
//  Copyright (c) 2015 Stefandeclerck. All rights reserved.
//

import UIKit
import Parse
import SwiftyJSON

class YouVC: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var accountURLS: [String] = [String]()
    var indexCount: Int = 0
    var currentIndex: Int = 0
    
    @IBAction func share(sender: AnyObject) {
        let firstActivityItem = "Awesome Gif discovered with Jiphs app!: \(self.accountURLS[currentIndex])"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        println("swipeLeft")
        if self.currentIndex != 0 {
            self.currentIndex = self.currentIndex - 1
        } else {
            println("dick")
        }
        
        var urlStringSet: String = self.accountURLS[self.currentIndex]
        println(urlStringSet)
        let url = NSURL(string: urlStringSet)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
                
                let url = NSURL(string: urlStringSet)
                let requestObject = NSURLRequest(URL: url!)
                self.webView.loadRequest(requestObject)
            
        }
        task.resume()
        
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        println("swipeRight")
        if self.currentIndex != self.indexCount - 1 {
            self.currentIndex = self.currentIndex + 1
        } else {
            println("dick")
        }
        
        var urlStringSet: String = self.accountURLS[self.currentIndex]
        println(urlStringSet)
        let url = NSURL(string: urlStringSet)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
        
                println("dickfest")
                let url = NSURL(string: urlStringSet)
                let requestObject = NSURLRequest(URL: url!)
                self.webView.loadRequest(requestObject)
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.webView.backgroundColor = UIColor.clearColor()
        self.webView.opaque = false
        
        var currentUser = PFUser.currentUser()
        var currentUsername = currentUser?.username
        
        var query = PFQuery(className:"LikeClass")
        query.whereKey("user", equalTo:currentUsername!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectForKey("url"))
                        self.accountURLS.append(object.objectForKey("url") as! String)
                    }
                    println(self.accountURLS)
                    self.indexCount = self.accountURLS.count
                    println(self.indexCount)
                    
                    let url = NSURL(string: self.accountURLS[self.currentIndex])
                    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
                        (data, response, error) in
                        
                        if error == nil {
                            
                            let url = NSURL(string: self.accountURLS[self.currentIndex])
                            let requestObject = NSURLRequest(URL: url!)
                            self.webView.loadRequest(requestObject)
                            
                        }
                        
                    }
                    
                    task.resume()
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
    }
}

