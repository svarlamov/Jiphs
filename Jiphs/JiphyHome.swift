//
//  JiphyHome.swift
//  Jiphs
//
//  Created by Stefan DeClerck on 5/23/15.
//  Copyright (c) 2015 Stefandeclerck. All rights reserved.
//

import UIKit
import SwiftyJSON
import Parse


class JiphyHome: UIViewController, UISearchBarDelegate, UIWebViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: UIWebView!
    
    var currentWVURL = ""
    
    var currentIndex = 0
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    @IBAction func likeGif(sender: AnyObject) {
    
        var searchBarMainText1: String = searchBar.text;
        var searchBarFinal = searchBarMainText1.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        println(searchBarFinal)
        
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/search?q=\(searchBarFinal)&api_key=dc6zaTOxFJmzC&limit=100")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                
                let urlContent = JSON(data: data)
                let jiphData = urlContent["data"][0]["images"]["original"]["url"].stringValue
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
    
    @IBAction func signOut(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        self.performSegueWithIdentifier("logOut", sender:self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.webView.backgroundColor = UIColor.clearColor()
        self.webView.opaque = false
        
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/search?q=Horse&api_key=dc6zaTOxFJmzC&limit=100")
        searchBar.text = "Gif"
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                
                let urlContent = JSON(data: data)
                let jiphData = urlContent["data"][self.currentIndex]["images"]["original"]["url"].stringValue
                println(jiphData)
                
                let url = NSURL(string: jiphData)
                self.currentWVURL = jiphData
                println("test = \(self.currentWVURL)")
                let requestObject = NSURLRequest(URL: url!)
                self.webView.loadRequest(requestObject)
                
            }
            
        }
        
        task.resume()
        
        searchBar.delegate = self
        
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        if self.currentIndex != 99 {
            self.currentIndex = self.currentIndex + 1
        }
        var searchBarMainText1: String = searchBar.text;
        var searchBarFinal = searchBarMainText1.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        println(searchBarFinal)
        
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/search?q=\(searchBarFinal)&api_key=dc6zaTOxFJmzC&limit=100")
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
        
        println("swipe right")
    }
    
    @IBAction func share(sender: AnyObject) {
        
        let firstActivityItem = "Awesome Gif discovered with Jiphs app!: \(self.currentWVURL)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        var searchBarMainText1: String = searchBar.text;
        var searchBarFinal = searchBarMainText1.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        println(searchBarFinal)
        
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/search?q=\(searchBarFinal)&api_key=dc6zaTOxFJmzC&limit=100")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error == nil {
                
                let urlContent = JSON(data: data)
                let jiphData = urlContent["data"][0]["images"]["original"]["url"].stringValue
                println(jiphData)
                
                let url = NSURL(string: jiphData)
                let requestObject = NSURLRequest(URL: url!)
                self.webView.loadRequest(requestObject)
                
            }
            
        }
        
        task.resume()

    }

}
