//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Brendon Crowe on 3/1/23.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkMarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: ToDoCellDelegate?

    @IBAction func completeButtonPressed(_ sender: UIButton) {
        delegate?.checkMarkTapped(sender: self)
    }
}
