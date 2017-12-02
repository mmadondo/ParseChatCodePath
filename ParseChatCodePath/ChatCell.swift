//
//  ChatCell.swift
//  ParseChatCodePath
//
//  Created by Malvern Madondo on 12/2/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var chatMessage: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
