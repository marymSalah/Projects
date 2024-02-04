//
//  calendarTableViewCell.swift
//  LabCaught
//
//  Created by Fatima ahmed on 18/12/2023.
//

import UIKit
protocol calendarTableViewCellDelegate: AnyObject {
    func datePickerValueChanged(to date: Date)
}
class calendarTableViewCell: UITableViewCell {

    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: calendarTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        delegate?.datePickerValueChanged(to: sender.date)
    }

}
