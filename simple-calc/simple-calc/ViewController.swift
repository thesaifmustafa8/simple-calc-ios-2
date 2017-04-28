//
//  ViewController.swift
//  simple-calc
//
//  Created by Saif Mustafa on 4/20/17.
//  Copyright © 2017 saifm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var theDisplay: UILabel! // result view on calculator
    
    var theEquation : String = "";
    var mathStack : [String] = [""]; // keeping track of operands and numbers
    var index : Int = 0; // keeping track of where in the stack we are
    var forHistory : [String] = [""]; // keeping track of all calculations for history view
    
    // Factorial button with error handling
    @IBAction func mathFactorial(_ sender: UIButton) {
        
        if(UInt(self.mathStack[0]) == nil) { // not an INT number
            
            self.theDisplay.text = "Error!";
            self.mathStack = [""];
            
        } else {
            
            // because I took way too many math classes...
            if(Int(self.mathStack[0]) == 0) {
           
                self.theDisplay.text = String(1);  // 0! = 1
                self.mathStack = [String(1)];
                
                self.theEquation = self.theEquation + "! = " + String(String(1));
                
            } else {
            
                var fact = 1;
            
                for i in 1...Int(self.mathStack[0])! {
            
                    fact *= i;
            
                }
            
                self.theDisplay.text = String(fact);
                self.mathStack = [String(fact)];
                
                self.theEquation = self.theEquation + "! = " + String(fact);
                
            }
        
        }
        
        forHistory.append(self.theEquation);
        
        self.index = 0;
    
    }
    
    // Equal button that performs most math operations
    @IBAction func mathEquals(_ sender: UIButton) {
        
        self.index = 0; // starting from the first element in our stack
        var forCount = 1;
        var answer = Double(self.mathStack[0])!;
        
        while(self.index < self.mathStack.count) {
            
            switch(self.mathStack[self.index]) {
                
                case "+": // Addition
                    
                        answer = answer + Double(self.mathStack[self.index + 1])!;
                        self.index = self.index + 2;
                
                case "-": // Subtraction
                    
                        answer = answer - Double(self.mathStack[self.index + 1])!;
                        self.index = self.index + 2;
                
                case "x": // Multiplication
                    
                        answer = answer * Double(self.mathStack[self.index + 1])!;
                        self.index = self.index + 2;
                
                case "/": // Division
                    
                        answer = answer / Double(self.mathStack[self.index + 1])!;
                        self.index = self.index + 2;
                
                case "%": // Modulus
                    
                        answer = answer.truncatingRemainder(dividingBy: Double(self.mathStack[self.index + 1])!);
                        self.index = self.index + 2;
                
                case "count": // Count of number of inputs
                    
                        answer = 0;
                        self.index = self.index + 2;
                        forCount = forCount + 1;
                
                case "avg": // average of all inputs
                    
                        answer = answer + Double(self.mathStack[self.index + 1])!;
                        forCount = forCount + 1;
                        self.index = self.index + 2;
                
                default : self.index = self.index + 1;
                
            }
            
        }
        
        // final average calculation
        if(self.mathStack.contains("avg")) {
            
            answer = answer / Double(forCount);
            
        }
        
        // final count calculation
        if(self.mathStack.contains("count")) {
            
            answer = Double(forCount);
            
        }
        
        // resetting values
        self.mathStack = [""];
        self.index = 0;
        forCount = 1;
        
        self.theDisplay.text = String(answer);
        
        self.mathStack[0].append(String(answer));
        
        self.theEquation = self.theEquation + " = " + String(answer);
        forHistory.append(self.theEquation);
        
    }
    
    // AC button to clear all past calculation from memory
    @IBAction func clearEverything(_ sender: UIButton) {
        
        self.index = 0;
        self.mathStack = [""];
        self.theDisplay.text = "0";
        self.theEquation = "";
        
    }
    
    // Controller for major math operations
    @IBAction func mathAll(_ sender: UIButton) {
        
        if(sender.currentTitle! == "." || Double(sender.currentTitle!) != nil) {
            
            self.mathStack[self.index].append(sender.currentTitle!);
            
        } else { // not a number
            
            self.mathStack.append(sender.currentTitle!);
            self.mathStack.append(""); // placeholder
            
            self.index = self.index + 2;
            
        }
        
        self.theEquation = self.theEquation + sender.currentTitle!;
        
        // first
        if(self.theDisplay.text == "Error!" || self.theDisplay.text == "0") {
            
            self.theDisplay.text = String(sender.currentTitle!);
            
        } else { // append all numbers otherwise
            
            self.theDisplay.text?.append(String(sender.currentTitle!));
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "historySegue") {
            
            let history = segue.destination as! HistoryViewController;
            history.forHistory = forHistory;
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
