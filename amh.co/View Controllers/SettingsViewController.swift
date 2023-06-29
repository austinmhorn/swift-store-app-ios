//
//  SettingsViewController.swift
//  amh.co
//
//  Created by Austin Horn on 3/1/21.
//

import UIKit
import SwiftUI
import MessageUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SettingsViewController: UIViewController {

    @Environment(\.openURL) var openURL
    
    @IBOutlet var AccountButton: UIButton!
    @IBOutlet var NotificationsSwitch: UISwitch!
    @IBOutlet var SignOutButton: UIButton!
    @IBOutlet var ReportErrorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SignOutButtonTapped(_ sender: Any) {
        self.showSignOutPopUp()
    }
    
    @IBAction func ReportErrorButtonTapped(_ sender: Any) {
        openURL(URL(string: "https://forms.gle/5Ktd2ecEmbfBSmcW7")!)
    }
    
    // [START_VIEW_CONTROLLER_FUNCTIONS] //
    func showSignOutPopUp() {
        
        // Declare alert controller
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        
        // [START_CREATE_ACTIONS_FOR_(alert)_ALERT] //
        
        // User chose to stay signed in
        let staySignedInAction = UIAlertAction(title: "Stay signed in", style: .default) { (action) in
            print(action)
        }
        
        // User canceled alert
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print(action)
        }
        
        // User chose to sign out
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            
            // Make sure user is signed in before attempting to sign out
            if Auth.auth().currentUser != nil {
              // User is signed in...
                
              // Attempt sign out
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                }
                catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)

                }
                
                if Auth.auth().currentUser == nil {
                    self.transitionToStart()
                }
                
            }
            else {
              // No user is signed in...
                self.transitionToStart()
            }
            
        }
        
        // [END_CREATE_ACTIONS_FOR_(alert)_ALERT] //

        
        // Add actions to 'alert'
        alert.addAction(staySignedInAction)
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

    }
    
    /*
     
     // [CREATE_(alertError)_ALERT]
     let alertError = UIAlertController(title: "Error occurred", message: "Unknown error occurred while attempting to logout", preferredStyle: .alert)

     // [START_CREATE_ACTIONS_FOR_(alertError)_ALERT] //
     
     let dismissAction = UIAlertAction(title: "Dismiss", style: .default) { (action) in
         print(action)
     }
     
     // [END_CREATE_ACTIONS_FOR_(alertError)_ALERT] //
     // [START_ADD_ACTIONS_TO_(alertError)_ALERT] //
     
     alertError.addAction(dismissAction)
     
     // [END_ADD_ACTIONS_TO_(alertError)_ALERT] //
     // [PRESENT_(alert)_ALERT] //
     present(alertError, animated: true, completion: nil)

     */
    
    // Segue to View controller
    func transitionToStart() {
        let startupViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.startupViewController) as? ViewController
        
        view.window?.rootViewController = startupViewController
        view.window?.makeKeyAndVisible()
    }
    // [END_VIEW_CONTROLLER_FUNCTIONS] //
    
}
