//
//  HomeViewController.swift
//  amh.co
//
//  Created by Austin Horn on 2/19/21.
//

import UIKit

class AccessCodeViewController: UIViewController {
       
    @IBOutlet var accessCodeTextField: UITextField!
    @IBOutlet var validateAccessCodeButton: UIButton!
    @IBOutlet var errorMessage: UILabel!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setUpElements()
            viewWasTapped()
            // Do any additional setup after loading the view.
        }

    @IBAction func validateAccessCodeTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            // Error exists in the fields
            showError("Please fill in all fields")
        }
        else {
            
            // Clean up text
            let accessCodeCleanText = accessCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let alphaCode = "alphav1"
            
            if accessCodeCleanText == alphaCode {
                self.transitionToMainTabController()
            }
            else {
                showError("Invalid access code")
            }
            
        }

    }
    
    func setUpElements() {
        // Hide error message
        errorMessage.alpha = 0
    }
    
    func showError(_ message:String) {
        errorMessage.text = message
        errorMessage.alpha = 1
    }
    
    func validateFields() -> String? {
        // Check if any text fields are empty
        
        if accessCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please enter an access code"
        }
        
        return nil
    }
    
    // Hide keyboard if view is tapped
    func viewWasTapped() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func transitionToMainTabController() {
        let mainTabViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainTabViewController) as? MainTabViewController
        
        view.window?.rootViewController = mainTabViewController
        view.window?.makeKeyAndVisible()
    }
    
}
