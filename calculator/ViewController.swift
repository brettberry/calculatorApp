//
//  ViewController.swift
//  calculator
//
//  Created by Brett Berry on 5/6/15.
//  Copyright (c) 2015 Brett Berry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Label connection
    @IBOutlet weak var displayView: UILabel!
    
    // Variable boolean to track when an entry is complete
    var userIsInTheMiddleOfTypingANumber = false
    var hasDecimal = false
    
    // Instance of Calculator Brain Class
    var brain = CalculatorBrain()
    
    var displayValue: Double {
       
        get { // getting the string from the display and returning it as a numeric value
        
            return NSNumberFormatter().numberFromString(displayView.text!)!.doubleValue
        }
        
        set { // taking a numeric value from a calculator brain and returning a string
        
            displayView.text = "\(newValue)"
            
            userIsInTheMiddleOfTypingANumber = false
        
        }
        
    }

    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        

        if userIsInTheMiddleOfTypingANumber {
            
            if digit != "." {
                
                displayView.text = displayView.text! + digit
                    
            } else if hasDecimal == false {
                    
                displayView.text = displayView.text! + digit
                
                hasDecimal = true
            }
            
        } else {
            
            displayView.text = digit
            
            userIsInTheMiddleOfTypingANumber = true
            
            if digit == "." {
                
                hasDecimal = true
                
            }
        }
    }
    
    // Operation keys function
    @IBAction func operate(sender: UIButton) {
        
        if userIsInTheMiddleOfTypingANumber {
            
            enterKey()
            
        }
        
        if let operation = sender.currentTitle {
        
            if let result = brain.performOperation(operation) {
            
                displayValue = result
            
            } else {
            
                displayValue = 0
            
            }
        }
    }
    
    
    // Enter key function
    @IBAction func enterKey() {
        
        userIsInTheMiddleOfTypingANumber = false
        
        hasDecimal = false
        
        if let result = brain.pushOperand(displayValue) {
            
            displayValue = result
        
        } else {
            
            displayValue = 0
            
        }
    }
    
}

