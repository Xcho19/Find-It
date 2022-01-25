//
//  AddPlayerTableViewCell.swift
//  Find It
//
//  Created by Xcho on 25.01.22.
//

import Foundation
import UIKit

protocol PlayerNameDelegate: AnyObject {

}

final class AddPlayerTableViewCell: UITableViewCell {
    
    @IBOutlet var playerNameTextField: UITextField!
}
