//
//  gradeEvalsCell.swift
//  RES
//
//  Created by Daniel James on 12/12/19.
//  Copyright © 2019 CUIP. All rights reserved.
//

import UIKit

class gradeEvalsCell: UITableViewCell {

    @IBOutlet weak var attendeeName: UILabel!
    
    @IBOutlet weak var procedure: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
