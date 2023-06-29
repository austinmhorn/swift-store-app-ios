//
//  ViewController.swift
//  amh.co
//
//  Created by Austin Horn on 2/19/21.
//
// Photos by Ben Eaton
// Link to Ben Eaton's Unsplash.com
/* <span>Photo by <a href="https://unsplash.com/@beneaton7?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Ben Eaton</a> on <a href="https://unsplash.com/backgrounds/phone/iphone?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> */
//
//


import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet var welcomeGreeting: UILabel!
    @IBOutlet var noAccountMessage: UILabel!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        Auth.auth().addStateDidChangeListener { auth, user in
          if user != nil {
            // User is signed in.
            self.transitionToMainTabController()
          } else {
            // No user is signed in.
          }
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    @IBAction func signUpPressed(_ sender: Any) {
    }
    
    func transitionToMainTabController() {
        let mainTabViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mainTabViewController) as? MainTabViewController
        
        view.window?.rootViewController = mainTabViewController
        view.window?.makeKeyAndVisible()
    }
    
}

