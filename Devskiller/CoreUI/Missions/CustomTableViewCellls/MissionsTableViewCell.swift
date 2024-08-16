//
//  MissionsTableViewCell.swift
//  Devskiller
//
//  Created by Grey  on 09.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import UIKit

class MissionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var rocketLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var dateLaunchLabel: UILabel!
    @IBOutlet weak var checkImageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .systemBackground
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
