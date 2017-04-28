//
//  HistoryViewController.swift
//  simple-calc
//
//  Created by Saif Mustafa on 4/25/17.
//  Copyright © 2017 saifm. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController : UIViewController {
    
    public var forHistory : [String] = [""];
    var equations : String = "";
    
    @IBOutlet weak var historyList: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        var space : CGFloat = 65;
        
        for eq in forHistory {
            
            let label = UILabel(frame : CGRect(x: 10, y: 0, width: 375, height: space));
            label.text = eq;
            self.view.addSubview(label);
            space += 65;
            label.text! = eq;
            historyList.addSubview(label);
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning();
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let history = segue.destination as! ViewController;
        history.forHistory = forHistory;
        
    }
    
}
