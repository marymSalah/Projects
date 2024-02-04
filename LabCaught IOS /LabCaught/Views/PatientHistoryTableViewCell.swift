//
//  PatientHistoryTableViewCell.swift
//  LabCaught
//
//  Created by Maryam Salah Hashem Adnan Saleh on 13/12/2023.
//

import UIKit

class PatientHistoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var testName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
