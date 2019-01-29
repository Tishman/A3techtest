//
//  UserTableViewCell.swift
//  A3TechTest
//
//  Created by Роман Тищенко on 22/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    func setUpCellStyle() {
        self.accessoryType = .disclosureIndicator
    }
    
    func updateCell(user: User) {
        self.userName.text = user.name
    }
}
