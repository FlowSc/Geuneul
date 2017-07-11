//
//  SwitchTableViewCell.swift
//  Geuneul
//
//  Created by Kang Seongchan on 2017. 7. 11..
//  Copyright © 2017년 Kang Seongchan. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var autoLoginSwitchOutlet: UISwitch!
    var delegate:SettingSwitchDelegate?

    @IBAction func autoLoginSwitch(_ sender: UISwitch) {
        delegate?.loginValueChanged(self, value: sender.isOn)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitle("자동로그인 설정")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle(_ title:String) {
        titleLabel.text = title
    }

}

protocol SettingSwitchDelegate {
    func loginValueChanged(_ cell:SwitchTableViewCell, value:Bool)
}
