//
//  PrepareTableViewCell.swift
//  Cuisiner
//
//  Created by Fatih Gursoy on 15.03.2022.
//

import UIKit

class PrepareTableCell: UITableViewCell {

    static let identifier = "PrepareTableCell"
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    
    override func layoutSubviews() {
        
        rowLabel.layer.cornerRadius = rowLabel.frame.width / 2
        rowLabel.clipsToBounds = true
        
        textView.layer.cornerRadius = 20.0
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = UIColor(named:"Dark Red")?.cgColor
        
        textView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
    }
    
    func configure(instruction: Instruction?) {
        
        guard let instruction = instruction else {return}
        textView.text = instruction.text
        rowLabel.text = instruction.step
        
        if let time = instruction.time {
            timeTextField.text = String(describing: time)
        }
    }
    
}
