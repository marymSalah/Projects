//
//  PatientHomeViewController.swift
//  LabCaught
//
//  Created by Nada Naser Ahmed Abdulla Abdulkarim Alawadhi on 20/12/2023.
//

import UIKit
import FirebaseStorage

class PatientHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var closeingLbl: UILabel!
    @IBOutlet weak var openingLbl: UILabel!
    @IBOutlet var specializationLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var facility: Facility?
    var services: [Service] = []
    var filteredServices: [Service] = []
    
    init?(coder: NSCoder, facility: Facility?){
        self.facility = facility
        if let facility = facility{
            services = AppData.getServices(facility: facility)
            filteredServices = services.compactMap{ $0 as? Test }
        }
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.facility = nil
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        tableView.dataSource = self
    }
    
    func updateViews() {
        guard let facility = facility else { return }
        
        nameLbl.text = facility.name
        locationLbl.text = facility.location
        specializationLbl.text = facility.facilityType.description
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let opendate = calendar.date(from: facility.openingTime)
        var timeString = dateFormatter.string(from: opendate!)
        openingLbl.text = timeString
        
        let closedate = calendar.date(from: facility.openingTime)
        timeString = dateFormatter.string(from: closedate!)
        closeingLbl.text = timeString
        
        //imageView.image = UIImage //UIImage(named: facility.logoImageName)
        
        facility.fetchLogoImage { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    
    @IBAction func sortBtn(_ sender: Any) {
        let actionSheetController = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let ZtoA = UIAlertAction(title: "Z-A", style: .default) { action in
            self.filteredServices.sort { $0.name > $1.name }
            self.tableView.reloadData()
        }
        let AtoZ = UIAlertAction(title: "A-Z", style: .default) { action in
            self.filteredServices.sort { $0.name < $1.name }
            self.tableView.reloadData()
        }
        
        // Add actions to actionSheetController
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(AtoZ)
        actionSheetController.addAction(ZtoA)
        
        // barButtonItem will be deprecated change it later
        actionSheetController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PHFCell", for: indexPath) as! PatientHomeFacilityTableViewCell
        
        let service = filteredServices[indexPath.row]
        
        cell.configure(service: service)

        return cell
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            filteredServices = services.compactMap{ $0 as? Test}
        } else {
            filteredServices = services.compactMap{ $0 as? Packages}
        }
        
        tableView.reloadData()
    }
    
    

    
    // MARK: - Navigation
    
    @IBSegueAction func bookPage(_ coder: NSCoder, sender: Any?) -> bookableViewController? {
        
        var choosenService: Service?
        if let cell = sender as? PatientHomeFacilityTableViewCell,
           let indexPath = tableView.indexPath(for: cell){
            choosenService = filteredServices[indexPath.row] as Service
        }
        
        return bookableViewController(coder: coder, service: choosenService)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? bookableViewController, let selected = tableView.indexPathForSelectedRow{
            destination.test = filteredServices[selected.row]
        }
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
