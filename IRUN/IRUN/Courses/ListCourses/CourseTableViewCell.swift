//
//  CourseTableViewCell.swift
//  IRUN
//
//  Created by VIDAL Léo on 24/07/2021.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
