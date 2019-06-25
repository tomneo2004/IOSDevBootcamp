//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Nelson on 25/6/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ballArray = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    
    @IBOutlet weak var ballImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateAnswer()
    }

    @IBAction func askButtonPress(_ sender: UIButton) {
        
        updateAnswer()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        updateAnswer()
    }
    
    func updateAnswer(){
        
        let randomAnswer : Int = Int.random(in: 0 ... 4)
        ballImageView.image = UIImage(named: ballArray[randomAnswer])
    }
}

