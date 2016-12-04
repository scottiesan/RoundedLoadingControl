//
//  ViewController.swift
//  RoundedLoadingControl
//
//  Created by Scott Ho on 12/3/16.
//  Copyright © 2016 Scott Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loading: RoundedLoading!
    @IBOutlet weak var percentageInput: UITextField!
    @IBAction func onClick(_ sender: Any) {
        
        if let n = NumberFormatter().number(from: percentageInput.text!) {
            loading.currentValue = CGFloat(n)
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

