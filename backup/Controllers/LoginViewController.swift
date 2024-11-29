//
//  LoginViewController.swift
//  backup
//
//  Created by Rahul Acharya on 29/11/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUP: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func signUPTapped(_ sender: UIButton) {
        // Ensure that email and password are not empty
           guard let emailText = email.text, !emailText.isEmpty,
                 let passwordText = password.text, !passwordText.isEmpty else {
               showAlert(message: "Please enter email and password.")
               return
           }
        
        // Create user with Firebase Authentication
          Auth.auth().createUser(withEmail: emailText, password: passwordText) { result, error in
              if let error = error {
                  self.showAlert(message: "Sign-up failed: \(error.localizedDescription)")
                  return
              }
              // Successful sign-up
              self.showAlert(message: "User signed up successfully!")
              // You can navigate to another screen if needed
              // self.navigateToHome()
          }
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // Ensure that email and password are not empty
              guard let emailText = email.text, !emailText.isEmpty,
                    let passwordText = password.text, !passwordText.isEmpty else {
                  showAlert(message: "Please enter email and password.")
                  return
              }
              
              // Sign in the user with Firebase Authentication
              Auth.auth().signIn(withEmail: emailText, password: passwordText) { result, error in
                  if let error = error {
                      self.showAlert(message: "Login failed: \(error.localizedDescription)")
                      return
                  }
                  // Successful login
//                  self.showAlert(message: "Logged in successfully!")
                  // You can navigate to another screen if needed
                   self.navigateToHome()
              }
    }
    
    // Show an alert to the user
     private func showAlert(message: String) {
         let alert = UIAlertController(title: "Authentication", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
     
     // Navigate to another view controller (for example, Home)
     private func navigateToHome() {
         // Assuming you have a HomeViewController
         if let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
             navigationController?.pushViewController(homeVC, animated: true)
         }
     }
}
