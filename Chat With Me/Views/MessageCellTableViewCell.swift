//
//  MessageCellTableViewCell.swift
//  Chat With Me
//
//  Created by Beltrami Dias Batista, Thiago on 08/04/22.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var viewMessageBalloon: UIView!
    @IBOutlet weak var labelMessageText: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var stackMessage: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMessageBalloon.layer.cornerRadius = viewMessageBalloon.frame.height/5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
