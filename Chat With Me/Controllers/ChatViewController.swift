//
//  ChatViewController.swift
//  Chat With Me
//
//  Created by Beltrami Dias Batista, Thiago on 06/04/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldMessage: UITextField!
    
    //MARK: - Contants
    let dataBase = Firestore.firestore()
    
    //MARK: - Variables
    var messages: [Message] = []
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
      
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        retrieveMessages()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    //MARK: - Model functions
    func retrieveMessages(){
        
        dataBase.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener
        { (querySnapshot, error) in
            if let error = error {
                print("There was an issue retrieving data from Firestore, \(error)")
            } else {
                self.messages = []
                if let snapshotDocuments = querySnapshot?.documents {
                    for documents in snapshotDocuments {
                        let data = documents.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Navigation
    @IBAction func didTapSendMessage(_ sender: UIButton) {
        
        if let messageBody = textFieldMessage.text, let messageSender = Auth.auth().currentUser?.email {
            
            dataBase.collection(K.FStore.collectionName).addDocument(data: [
                                                                K.FStore.senderField: messageSender,
                                                                K.FStore.bodyField: messageBody,
                                                                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let error = error {
                    print("there was a issue saving data to firestore, \(error)")
                } else {
                    print("Successfullly saved data")
                    self.textFieldMessage.text = ""
                }
            }
            
        }
        
    }
    
    @IBAction func didTapSignOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    

}

//MARK: - Extension for UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let whoisMessage = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCellTableViewCell
        cell.labelMessageText.text = whoisMessage.body
        
        if whoisMessage.sender != Auth.auth().currentUser?.email {
            
            cell.stackMessage.semanticContentAttribute = .forceRightToLeft
            cell.imageAvatar.image = UIImage(systemName:"person.circle")
            cell.imageAvatar.tintColor = UIColor(named: K.Colors.secondaryColor)
            cell.viewMessageBalloon.backgroundColor = UIColor(named: K.Colors.secondaryColor)
            
        } else {
            cell.stackMessage.semanticContentAttribute = .forceLeftToRight
            cell.imageAvatar.image = UIImage(systemName:"person.circle.fill")
            cell.imageAvatar.tintColor = UIColor(named: K.Colors.primaryColor)
            cell.viewMessageBalloon.backgroundColor = UIColor(named: K.Colors.primaryColor)
            
        }
        
        
        return cell
    }
      
}

