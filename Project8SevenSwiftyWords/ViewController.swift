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
        
        loadLevel()
    }
    
    func letterTapped(btn: UIButton) {
        //gets the text from the title label of the button that was tapped and appends it to the current text of the answer text field
        currentAnswer.text = currentAnswer.text + btn.titleLabel!.text!
        //appends the button to the activatedButtons array
        activatedButton.append(btn)
        //finally hides the button
        btn.hidden = true
    }
    
    func loadLevel() {
        //store all the level's clues
        var clueString = ""
        //store how many letters each answer is
        var solutionString = ""
        //an array to store all letter groups
        var letterBits = [String]()
        
        if let levelFilePath = NSBundle.mainBundle().pathForResource("level\(level)", ofType: "txt") {
            if let levelContents = NSString(contentsOfFile: levelFilePath, usedEncoding: nil, error: nil) {
                var lines = levelContents.componentsSeparatedByString("\n")
                lines.shuffle()
                
                //enumerate() will place the item into the line variable and its position into the index variable
                for (index, line) in enumerate(lines as! [String]) {
                    let parts = line.componentsSeparatedByString(": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    //The array indexes start from 0, so add 1 to make it count from 1 to 7
                    clueString += "\(index + 1). \(clue)\n"
                    
                    //Asking it to replace all instances of | with an empty string
                    let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                    solutionString += "\(count(solutionWord)) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.componentsSeparatedByString("|")
                    letterBits += bits
                }
            }
        }
        //Now configure the buttons and labels
        
        //removes any letters specify from the start and end of a string, used with the parameter .whitespaceAndNewlineCharacterSet(), which trims spaces, tabs and line breaks
        cluesLabel.text = clueString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        answersLabel.text = solutionString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        
        letterBits.shuffle()
        letterButton.shuffle()
        
        if letterBits.count == letterButton.count {
            //looping from 0 to 19 means we can use the i variable to set a button to a letter group
            for i in 0 ..< letterBits.count {
                letterButton[i].setTitle(letterBits[i], forState: .Normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

