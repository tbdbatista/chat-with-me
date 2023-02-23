//
//  RegisterViewController.swift
//  Chat With Me
//
//  Created by Beltrami Dias Batista, Thiago on 06/04/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelMain: UILabel!
    
    //MARK: - Variables and Constants
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func didTapRegister(_ sender: UIButton) {
    
        if let email = textFieldEmail.text, let password = textFieldPassword.text {    
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    print("***************************")
                    print(error)
                } else {
                    self.performSegue(withIdentifier: K.segueRegister, sender: self)
                }
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
