//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let swifter = Swifter(consumerKey: "qWMKX4FFaAf221gs0PQY3hA8J", consumerSecret: "udLLKbgBm6uMhRdiYJkrM5Av2uKLPkpIg5JxiNsL6BaNJ4dCpe")
    
    let sentimentClassifier = sentimentTweet()
    
    let tweetCount = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    @IBAction func predictPressed(_ sender: Any) {
    
        guard let text = textField.text else{
            return
        }
        
        fetchTweets(text: text)
    }
    
    
    func fetchTweets(text:String){
        
        swifter.searchTweet(using: text, lang:"en", count:tweetCount, tweetMode:.extended, success: { (results, metadata) in
            
            var tweets = [sentimentTweetInput]()
            
            for i in 0..<self.tweetCount{
                if let tweet = results[i]["full_text"].string{
                    let sentimentClassifierInput = sentimentTweetInput(text: tweet)
                    tweets.append(sentimentClassifierInput)
                }
            }
            
            self.predict(tweets)
            
        }) { (error) in
            print(error);
        }
    }
    
    func predict(_ tweets:[sentimentTweetInput]){
        
        do{
            let predictions =  try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for pred in predictions{
                let sentiment = pred.label
                
                if sentiment == "Pos"{
                    sentimentScore += 1
                }
                else if sentiment == "Neg"{
                    sentimentScore -= 1
                }
            }
            
            print(sentimentScore)
            
            updateUI(sentimentScore)
            
            
            
        }catch{
            
            print(error);
        }
    }
    
    func updateUI(_ sentimentScore:Int){
        
        if sentimentScore > 20{
            self.sentimentLabel.text = "😍"
        }
        else if sentimentScore < -20{
            self.sentimentLabel.text = "☹️"
        }
        else{
            self.sentimentLabel.text = "😐"
        }
    }
}

