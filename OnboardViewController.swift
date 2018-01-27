//
//  OnboardViewController.swift
//  Episode
//
//  Created by Parambir Bajwa on 1/26/18.
//  Copyright © 2018 Parambir Bajwa. All rights reserved.
//

import UIKit
import Firebase

class OnboardViewController: UIViewController {
    
    var ref = Database.database().reference()
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passField: UITextField!
    @IBOutlet var pass2Field: UITextField!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var feetField: UITextField!
    @IBOutlet var inchesField: UITextField!
    @IBOutlet var addMedField: UITextField!
    @IBOutlet var medList: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        self.navigationController?.isNavigationBarHidden = false;
        
        //hide keyboard when tapped around
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OnboardViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ageSlider(_ sender: UISlider) {
        ageLabel.text = String(Int(sender.value))
    }
    
    @IBAction func weightSlider(_ sender: UISlider) {
        weightLabel.text = String(Int(sender.value))
    }

    @IBAction func addMed(_ sender: UIButton) {
        if (medList.text == "No Medications."){
            medList.text = addMedField.text;
            addMedField.text = ""
        } else {
            medList.text = medList.text + ", " + addMedField.text!
            addMedField.text = ""
        }
        dismissKeyboard()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!) { (user, error) in
            if ((error) == nil) {
                let inInches = Int(self.feetField.text!)! * 12 + Int(self.inchesField.text!)!
                self.ref.child("users").child((user?.uid)!).updateChildValues(["weight": Int(self.weightLabel.text!), "age": Int(self.ageLabel.text!), "height": inInches]);
                    if (self.medList.text != "No Medications.") {
                        let meds = self.medList.text.components(separatedBy: ",");
                        for med in meds {
                            let key = self.ref.child("users").child((user?.uid)!).child("medications").childByAutoId().key;
                            self.ref.child("users").child((user?.uid)!).child("medications").child(key).setValue(med);
                        }
                    }
                print("user saved")
                self.performSegue(withIdentifier: "signedUp", sender: nil)
            } else {
                let alert = UIAlertController(title: "Failure", message: "Unable to sign up.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(error ?? "undefined error")
            }
        }
    }
    


}
