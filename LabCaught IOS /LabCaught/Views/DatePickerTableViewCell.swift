//
//  DatePickerTableViewCell.swift
//  LabCaught
//
//  Created by Fatima ahmed on 26/12/2023.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {
    
    // Add a UIDatePicker as a property of the cell
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false // Use Auto Layout
        picker.datePickerMode = .date // Set the picker mode as needed
        return picker
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupDatePicker()
    }

    private func setupDatePicker() {
        // Add the datePicker to the cell's view
        self.contentView.addSubview(datePicker)

        // Set up constraints for the datePicker
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

