//
//  SelectTestsTableViewController.swift
//  LabCaught
//
//  Created by Sara Khalifa Ebrahim Khalifa Hamdan on 04/01/2024.
//

import UIKit

class SelectTestsTableViewController: UITableViewController {
    
    let allTests: [Test] = AppData.tests.filter { $0.facility.username == AppData.getLoggedInUsername() }
    var selectedTests = [Test]()
    weak var delegate: SelectTestsDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            let selectedTests = getSelectedTests()
            delegate?.didSelectTests(selectedTests)
        }
    }
    
    required init?(coder: NSCoder, tests: [Test]) {
        selectedTests = tests
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        selectedTests = []
        super.init(coder: coder)
    }
    
    
    func getSelectedTests() -> [Test] {
            var tests: [Test] = []
            
            // Loop through the table view rows
            for row in 0..<tableView.numberOfRows(inSection: 0) {
                let indexPath = IndexPath(row: row, section: 0)
                if let cell = tableView.cellForRow(at: indexPath) {
                    // Check if the cell has a checkmark
                    if cell.accessoryType == .checkmark {
                        // Add the corresponding test from allTests to selectedTests
                        tests.append(allTests[row])
                    }
                }
            }
            return tests
        }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        let test = allTests[indexPath.row]
        cell.textLabel?.text = test.name

        // Check if the test is in selectedTests
        if selectedTests.contains(where: { $0 == test }) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                } else {
                    cell.accessoryType = .checkmark
                }
            }
    }
    
    
}
protocol SelectTestsDelegate: AnyObject {
    func didSelectTests(_ tests: [Test])
}
