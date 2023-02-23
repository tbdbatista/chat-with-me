//
//  Constants.swift
//  Chat With Me
//
//  Created by Beltrami Dias Batista, Thiago on 08/04/22.
//

struct K {
    static let appName = "Chat With Me"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCellTableViewCell"
    static let segueRegister = "RegisterToChat"
    static let segueLogin = "LoginToChat"
    
    struct FStore {
            static let collectionName = "messages"
            static let senderField = "sender"
            static let bodyField = "body"
            static let dateField = "date"
        }
    
    struct Colors {
        static let primaryColor = "FirstColor"
        static let secondaryColor = "SecondColor"
    }
}
