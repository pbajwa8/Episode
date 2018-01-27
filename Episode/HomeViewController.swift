//
//  ViewController.swift
//  Episode
//
//  Created by Parambir Bajwa on 10/3/17.
//  Copyright © 2017 Parambir Bajwa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: UIButton) {
    }
 

}

