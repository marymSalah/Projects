//
//  ServiceFormTableViewController.swift
//  LabCaught
//
//  Created by Sara Khalifa Ebrahim Khalifa Hamdan on 20/12/2023.
//

import UIKit

class ServiceFormTableViewController: UITableViewController {
    
    
    var includedTests = [Test]()
    
    @IBOutlet weak var serviceTypeSC: UISegmentedControl!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var costTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var instructionsTxt: UITextView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var testsList: UILabel!
    @IBOutlet weak var expiryDate: UIDatePicker!
    
    
    enum ServiceFormSection: Int, CaseIterable {
        case seg = 0
        case name
        case cost
        case description
        case instructions
        case packageItems
        case expiryDate
        
        static var count: Int {
            return self.allCases.count
        }
    }
    
    enum ServiceType: Int {
        case test = 0, package
    }
    
    var currentServiceType: ServiceType = .test
    
    var service: Service?
    
    var name: String = ""
    var cost: String = ""
    var descrip: String = ""
    var instructions: String = ""
    
    init?(coder: NSCoder, service: Service) {
        self.service = service
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.service = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceTypeChanged(serviceTypeSC)
        updateViews()
        
        
        //border color, width, and corner radius
        descriptionTxt.layer.borderColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        descriptionTxt.layer.borderWidth = 1.0
        descriptionTxt.layer.cornerRadius = 5.0
        instructionsTxt.layer.borderColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        instructionsTxt.layer.borderWidth = 1.0
        instructionsTxt.layer.cornerRadius = 5.0
        
        testsList.numberOfLines = 0
        testsList.adjustsFontSizeToFitWidth = true
        testsList.minimumScaleFactor = 0.5
    }
    
    func updateViews() {
        guard let service = service else {
            title = "Add Service"
            return
        }
        
        title = "Edit Service"
        nameTxt.text = service.name
        costTxt.text = "\(service.cost)"
        descriptionTxt.text = service.describtion
        instructionsTxt.text = service.insrtuctions
        
        if service is Test {
            serviceTypeSC.selectedSegmentIndex = ServiceType.test.rawValue
            currentServiceType = .test
        } else if let package = service as? Packages {
            serviceTypeSC.selectedSegmentIndex = ServiceType.package.rawValue
            currentServiceType = .package
            
            includedTests = package.packageIncludes
            testsList.text = includedTests.map { $0.name }.joined(separator: ", ")
            
            // Convert DateComponents to Date
            if let expiryDateFromComponents = Calendar.current.date(from: package.packageExpiry) {
                expiryDate.date = expiryDateFromComponents
            } else {
                expiryDate.date = Date() // setting to current date as a fallback
            }
        }
        tableView.reloadData()
    }

    
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
        guard let name = nameTxt.text, !name.isEmpty,
                  let cost = costTxt.text, !cost.isEmpty,
                  let description = descriptionTxt.text, !description.isEmpty,
                  let instructions = instructionsTxt.text, !instructions.isEmpty else {
                presentAlert(withTitle: "Missing Information", message: "Please fill in all fields.")
                return
            }

            // Package-specific validation
            if currentServiceType == .package {
                guard includedTests.count >= 2 else {
                    presentAlert(withTitle: "Insufficient Tests", message: "Please select at least two tests for the package.")
                    return
                }

                let expiryDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: expiryDate.date)
                guard expiryDateComponents.isValidDate(in: Calendar.current) else {
                    presentAlert(withTitle: "Missing Expiry Date", message: "Please choose an expiry date for the package.")
                    return
                }
            }
            
            // Update or create new service
            if let existingService = service as? Packages {
                existingService.name = name
                existingService.cost = cost
                existingService.describtion = description
                existingService.insrtuctions = instructions
                existingService.packageIncludes = includedTests
                existingService.packageExpiry = Calendar.current.dateComponents([.year, .month, .day], from: expiryDate.date)
            } else if let existingService = service {
                existingService.name = name
                existingService.cost = cost
                existingService.describtion = description
                existingService.insrtuctions = instructions
            } else {
                let facility: Facility = AppData.facilites.first(where: {$0.username == AppData.getLoggedInUsername()})!
                
                if currentServiceType == .package {
                    let packageExpiry = Calendar.current.dateComponents([.year, .month, .day], from: expiryDate.date)
                    let newPackage = Packages(name: name, cost: cost, describtion: description, insrtuctions: instructions, packageIncludes: includedTests, packageExpiry: packageExpiry, facility: facility)
                    AppData.services.append(newPackage)
                } else {
                    let newTest = Test(name: name, cost: cost, describtion: description, insrtuctions: instructions, facility: facility)
                    AppData.services.append(newTest)
                }
            }

            // Update the AppData array if the service already existed
            if let existingService = service, let index = AppData.services.firstIndex(where: { $0 === existingService }) {
                AppData.services[index] = existingService
            }

            // Save the updated services to persistent storage
            // AppData.saveServicesToFile()

            // Notify any listeners that the services have been updated (e.g., the list view controller)
            NotificationCenter.default.post(name: NSNotification.Name("ServiceListShouldRefresh"), object: nil)

            // Dismiss the current view controller to return to the list view
            navigationController?.popViewController(animated: true)
        
        AppData.saveToFile()
    }
    
    
    private func presentAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentServiceType == .package && (section == ServiceFormSection.packageItems.rawValue || section == ServiceFormSection.expiryDate.rawValue) {
            return 1 // Assuming there is 1 row in each of these sections for packages
        } else if currentServiceType == .test && (section == ServiceFormSection.packageItems.rawValue || section == ServiceFormSection.expiryDate.rawValue) {
            return 0 // Hide rows for tests
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // If 'Tests' is selected and the section is 'packageItems' or 'expiryDate', return an empty string.
        if currentServiceType == .test && (section == ServiceFormSection.packageItems.rawValue || section == ServiceFormSection.expiryDate.rawValue) {
            return ""
        }
        // For all other cases, return the normal section title.
        return super.tableView(tableView, titleForHeaderInSection: section)
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        return cell
        //tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    
    @IBAction func serviceTypeChanged(_ sender: UISegmentedControl) {
        currentServiceType = sender.selectedSegmentIndex == 0 ? .test : .package
        tableView.reloadData()
    }
    
    @IBSegueAction func goToTestsPage(_ coder: NSCoder) -> UITableViewController? {
        let selectTestsVC = SelectTestsTableViewController(coder: coder, tests: includedTests)
        selectTestsVC?.delegate = self
        return selectTestsVC
    }
}
extension ServiceFormTableViewController: SelectTestsDelegate {
    func didSelectTests(_ tests: [Test]) {
        includedTests = tests
        testsList.text = includedTests.map { $0.name }.joined(separator: ", ")
    }
}
