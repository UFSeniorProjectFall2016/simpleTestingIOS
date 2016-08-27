//
//  MyCustomTableViewCell.swift
//  SocketChat
//
//  Created by Anthony Colas on 7/16/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
protocol MyCustomTableViewCellDelegate{
    func didTappedSwitch(cell: MyCustomTableViewCell)
}

class MyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changed: UISwitch!
    var delegate: MyCustomTableViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupWithModel(model: MyCustomTableViewCellModel){
        nameLabel.text = model.deviceName
        changed.setOn(model.changed, animated: false)
        
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate.didTappedSwitch(self)
        
        /*if nameLabel == "Door"{
            print("door")
        }*/
    }
}
