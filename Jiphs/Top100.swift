//
//  Top100.swift
//  Jiphs
//
//  Created by Stefan DeClerck on 5/24/15.
//  Copyright (c) 2015 Stefandeclerck. All rights reserved.
//

import SwiftyJSON
import UIKit
import Parse

class Top100: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var topNumberLabel: UILabel!
    
    var currentIndex = 0;
    var currentWVURL = ""
    
    @IBAction func like(sender: AnyObject) {
            
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=100")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                
                let urlContent = JSON(data: data)
                let jiphData = urlContent["data"][self.currentIndex]["images"]["original"]["url"].stringValue
                println(jiphData)
                
                self.currentWVURL = jiphData
                
            }
            
        }
        
        task.resume()
            
        var currentUser = PFUser.currentUser()
        var usernameP = currentUser?.username;
        
        var likedImage = PFObject(className:"LikeClass")
        likedImage["url"] = self.currentWVURL
        likedImage["user"] = usernameP
        likedImage.save()
        
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        
        println("swipeLeft")
        
        if self.currentIndex != 0 {
            self.currentIndex = self.currentIndex - 1
            var testNumber = self.currentIndex
            self.topNumberLabel.text = "Top \(testNumber) 😘"
        }
        
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=100")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                
                if self.currentIndex == 0 {
                    let urlContent = JSON(data: data)
                    let jiphData = urlContent["data"][0]["images"]["original"]["url"].stringValue
                    println(jiphData)
                    self.currentWVURL = jiphData
                    let url = NSURL(string: jiphData)
                    let requestObject = NSURLRequest(URL: url!)
                    self.webView.loadRequest(requestObject)
                } else {
                    let urlContent = JSON(data: data)
                    let jiphData = urlContent["data"][self.currentIndex]["images"]["original"]["url"].stringValue
                    println(jiphData)
                    self.currentWVURL = jiphData
                    let url = NSURL(string: jiphData)
                    let requestObject = NSURLRequest(URL: url!)
                    self.webView.loadRequest(requestObject)
                
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        
        println("swipeRight")
        
        if self.currentIndex != 99 {
            self.currentIndex = self.currentIndex + 1
            var testNumber = self.currentIndex + 1
            self.topNumberLabel.text = "Top \(testNumber) 😘"
        }
        
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=100")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                
                if self.currentIndex == 99 {
                    
                    let urlContent = JSON(data: data)
                    let jiphData = urlContent["data"][self.currentIndex]["images"]["original"]["url"].stringValue
                    println(jiphData)
                    let url = NSURL(string: jiphData)
                    let requestObject = NSURLRequest(URL: url!)
                    self.webView.loadRequest(requestObject)
                    self.currentWVURL = jiphData
                    
                } else {
                    let urlContent = JSON(data: data)
                    let jiphData = urlContent["data"][self.currentIndex]["images"]["original"]["url"].stringValue
                    println(jiphData)
                    let url = NSURL(string: jiphData)
                    let requestObject = NSURLRequest(URL: url!)
                    self.webView.loadRequest(requestObject)
                    self.currentWVURL = jiphData
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    @IBAction func share(sender: AnyObject) {
        
        let firstActivityItem = "Awesome Gif discovered with Jiphs app!: \(self.currentWVURL)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.webView.backgroundColor = UIColor.clearColor()
        self.webView.opaque = false
        
        var testNumber = self.currentIndex + 1
        self.topNumberLabel.text = "Top \(testNumber) 😘"
        
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=100")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                
                let urlContent = JSON(data: data)
                let jiphData = urlContent["data"][self.currentIndex]["images"]["original"]["url"].stringValue
                println(jiphData)
                
                self.currentWVURL = jiphData
                
                let url = NSURL(string: jiphData)
                let requestObject = NSURLRequest(URL: url!)
                self.webView.loadRequest(requestObject)
                
            }
            
        }
        
        task.resume()
        
    }

}
