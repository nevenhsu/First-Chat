//
//  UserCell.swift
//  First-Chat
//
//  Created by Neven on 22/10/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var firstNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setMark(selected: false)
    }

    func setMark(selected: Bool) {
        let imageName = selected ? "messageindicatorchecked2" : "messageindicatorchecked1"
        self.accessoryView = UIImageView(image: UIImage(named: imageName)  )
    }

    func updateUI(user: User) {
        firstNameLbl.text = user.firstName
    }
    
}
