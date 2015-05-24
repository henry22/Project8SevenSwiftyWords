//
//  ViewController.swift
//  Project8SevenSwiftyWords
//
//  Created by Henry on 5/21/15.
//  Copyright (c) 2015 Henry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    
    var letterButton = [UIButton]()
    var activatedButton = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    
    @IBAction func submitTapped(sender: AnyObject) {
    }
    
    @IBAction func clearTapped(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in view.subviews {
            if subview.tag == 1001 {
                let btn = subview as! UIButton
                letterButton.append(btn)
                //This is the code version of Ctrl-dragging in a storyboard and it lets us attach a method to the button click
                btn.addTarget(self, action: "letterTapped:", forControlEvents: .TouchUpInside)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

