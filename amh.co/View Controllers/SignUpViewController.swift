//
//  SignUpViewController.swift
//  amh.co
//
//  Created by Austin Horn on 2/19/21.
//

import SwiftUI
import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet var signUpGreeting: UILabel!
    @IBOutlet var firstname: UITextField!
    @IBOutlet var lastname: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var errorMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpElements()
        viewWasTapped()
    }
    
    // Hide keyboard if view was tapped
    func viewWasTapped() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }


    @IBAction func signUpPressed(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            // Error exists in the fields
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstnameCleanText = firstname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastnameCleanText = lastname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailCleanText = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordCleanText = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: emailCleanText, password: passwordCleanText) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // New user was successfully created
                    
                    /*
                    // Construct ActionCodeSettings for email link authentication
                    let actionCodeSettings = ActionCodeSettings()
                    actionCodeSettings.url = URL(string: "https://www.amhorn.com")
                    // The sign-in operation has to always be completed in the app.
                    actionCodeSettings.handleCodeInApp = true
                    actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
                    actionCodeSettings.setAndroidPackageName("com.example.android",
                                                             installIfNotAvailable: false, minimumVersion: "12")
                    
                    // Send authentication link to new user's email
                    Auth.auth().sendSignInLink(toEmail:emailCleanText,
                                               actionCodeSettings: actionCodeSettings) { error in
                      // ...
                        if let error = error {
                          self.showError(error.localizedDescription)
                          return
                        }
                        // The link was successfully sent. Inform the user.
                        // Save the email locally so you don't need to ask the user for it again
                        // if they open the link on the same device.
                        UserDefaults.standard.set(emailCleanText, forKey: "Email")
                    }
                    
                    */
                    
                    // Now store first name and last name
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data:["firstname":firstnameCleanText, "lastname":lastnameCleanText, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            self.showError("first name last name failed to save in user data")
                        }
                        
                    }
                    
                    self.transitionToAccessCodeViewController()
                    
                }
                
            }
                    
        }
        
    }
    
    // FUNCTIONS FOR THIS VIEW CONTROLLER //
    
    func showError(_ message:String) {
        errorMessage.text = message
        errorMessage.alpha = 1
    }
    
    func setUpElements() {
        // Hide error message
        errorMessage.alpha = 0
    }
    
    
    
    // Check the string and make sure it is valid. Returns nil if okay
    func validateFields() -> String? {
        // Check if any text fields are empty
        if firstname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "please fill in all fields"
        }
        
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "make sure your password is at least 8 characters, contains a special character, and a number."
        }
        
        return nil
    }
    
    // Segue to Access Code View Controller
    func transitionToAccessCodeViewController() {
        let accessCodeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.accessCodeViewController) as? AccessCodeViewController
        
        view.window?.rootViewController = accessCodeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
