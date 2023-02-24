//
//  LoginViewController.swift
//  Chat With Me
//
//  Created by Beltrami Dias Batista, Thiago on 06/04/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    strongSelf.performSegue(withIdentifier: K.segueLogin, sender: self)
                }
            }
        }
    }
}
