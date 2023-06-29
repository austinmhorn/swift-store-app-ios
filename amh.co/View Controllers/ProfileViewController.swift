//
//  ProfileViewController.swift
//  amh.co
//
//  Created by Austin Horn on 3/3/21.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let email_cell = tableView.dequeueReusableCell(withIdentifier: "email_cell", for: indexPath)
        
        // Get user profile from Firebase
        let user = Auth.auth().currentUser
        if user != nil {
            
            let userInfo = Auth.auth().currentUser?.providerData[indexPath.row]
            email_cell.textLabel?.text = userInfo?.providerID
            // Provider-specific UID
            email_cell.detailTextLabel?.text = userInfo?.uid
            
        }
            
        return email_cell
    }
    
}
