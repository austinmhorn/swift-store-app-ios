//
//  LoginViewController.swift
//  amh.co
//
//  Created by Austin Horn on 2/19/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var welcomeBackGreeting: UILabel!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorMessage: UILabel!
    

    
    // [START_viewWillLoad()] //
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
        viewWasTapped()
    }
    // [END_viewDidLoad()] //

    
    
    // Hide keyboard if view is tapped
    // [START_viewWasTapped] //
    func viewWasTapped() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    // [END_viewWasTapped] //
    
    
    // Login button action
    // [START_loginPressed()] //
    @IBAction func loginPressed(_ sender: Any) {
        
        // Validate text fields
        let error = validateFields()
        
        if error != nil {
            // Error exists in fields
            showError(error!)
        }
        
        // Clean text
        let emailCleanText = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordCleanText = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Sign user in
        Auth.auth().signIn(withEmail: emailCleanText, password: passwordCleanText) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.showError("invalid credentials")
            }
            else {
                
                self.transitionToMainTabViewController()
            }
            
        }
        
    }
    // [END_loginPressed()] //
    
    
    
    // Multi-error capability for 'errorMessage' text field:
    func showError(_ message:String) {
        errorMessage.text = message
        errorMessage.alpha = 1
    }
    
    
    
    // Hide error
    func setUpElements() {
        // Hide error message
        errorMessage.alpha = 0
    }
    
    
    
    // Check if text fields are empty
    func validateFields() -> String? {
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "please fill in all fields"
        }
        // All fields contain text; return no error
        return nil
    }
    
    
    
    // Segue to Main Tab View Controller
    func transitionToMainTabViewController() {
        let mainTabViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainTabViewController) as? MainTabViewController
        
        view.window?.rootViewController = mainTabViewController
        view.window?.makeKeyAndVisible()
    }
    
}
