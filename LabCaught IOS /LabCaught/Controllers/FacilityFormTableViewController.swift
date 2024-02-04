//
//  FacilityFormTableViewController.swift
//  LabCaught
//
//  Created by Shaikha Hasan Ali Hasan Ali Mohamed on 24/12/2023.
//

import UIKit
import Firebase
import FirebaseStorage


class FacilityFormTableViewController: UITableViewController {

        @IBOutlet weak var facilityTypeSC: UISegmentedControl!
        @IBOutlet weak var facilityLogo: UIImageView!
        @IBOutlet weak var facilityUsernameTextField: UITextField!
        @IBOutlet weak var facilityPasswordTextField: UITextField!
        @IBOutlet weak var facilityNameTextField: UITextField!
        @IBOutlet weak var facilityPhoneNumberTextField: UITextField!
        @IBOutlet weak var facilityLocationTextField: UITextField!
        @IBOutlet weak var isAlwaysOpenSwitch: UISwitch!
        @IBOutlet weak var openingTimeDP: UIDatePicker!
        @IBOutlet weak var closingTimeDP: UIDatePicker!

        @IBOutlet weak var btnSave: UIBarButtonItem!
        
        @IBOutlet weak var openingTimeCell: UITableViewCell!
        @IBOutlet weak var closingTimeCell: UITableViewCell!
    
        var facility: Facility?
    
        var currentFacilityType: FacilityType = .hospital
    
        var selectedImage: UIImage?
 

        var username: String = ""
        var password: String = ""
        var name: String = ""
        var phoneNumber: String = ""
        var location: String = ""
    
    init?(coder: NSCoder, facility: Facility?) {
        self.facility = facility
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.facility = nil
        super.init(coder: coder)
    }
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AppData.loadFacilities()
        updateViews()
        facilityIsAlwaysOpen(isAlwaysOpenSwitch)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(facilityLogoTapped))
        facilityLogo.addGestureRecognizer(tapGestureRecognizer)
    }


    func updateViews() {
             
            guard let facility = facility else {
                title = "Add Facility"
                return
            }
            
            title = "Edit Facility"
        
                // Update the UI elements with the data from the facility
                facilityUsernameTextField.text = facility.username
                facilityPasswordTextField.text = facility.password
                facilityNameTextField.text = facility.name
                facilityPhoneNumberTextField.text = "\(facility.phoneNumber)"
                facilityLocationTextField.text = facility.location
                isAlwaysOpenSwitch.isOn = facility.isOpen24Hours
                openingTimeDP.date = createDate(from: facility.openingTime) ?? Date()
                closingTimeDP.date = createDate(from: facility.closingTime) ?? Date()
        
        facility.fetchLogoImage { [weak self] image in
            DispatchQueue.main.async {
                self?.facilityLogo.image = image
            }
        }
        loadImage(from: facility.logoImageName, into: facilityLogo)

        
                // Set the segmented control for facility type
                facilityTypeSC.selectedSegmentIndex = facility.facilityType == .hospital ? 0 : 1

            // reload table view to reflect changes
            tableView.reloadData()

        
        
    }
    
    func createDate(from dateComponents: DateComponents) -> Date? {
                return Calendar.current.date(from: dateComponents)
            }

    func refreshFacilityList() {
        // Update your list view (e.g., tableView.reloadData())
        // Make sure to call this on the main thread if updating UI
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func svaeButtoPassed(_ sender: UIBarButtonItem) {
        
        // Gather data from UI elements
        let username = facilityUsernameTextField.text ?? ""
        let password = facilityPasswordTextField.text ?? ""
        let name = facilityNameTextField.text ?? ""
        let location = facilityLocationTextField.text ?? ""
  
        
        
        
        if username.isEmpty || password.isEmpty || name.isEmpty || location.isEmpty {
                           //Alert message
                           let alertController = UIAlertController(title: "Empty Fields", message: "Please fill the empty fields.", preferredStyle: .alert)
                           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                           alertController.addAction(okAction)
                           present(alertController, animated: true, completion: nil)
                           return
        }

       
        
        if let imageToUpload = selectedImage {
                uploadImage(imageToUpload) { [weak self] (url) in
                    guard let self = self, let logoUrl = url else {
                        self?.presentAlert(title: "Upload Failed", message: "Failed to upload image.")
                        return
                    }

                    // Store the image URL in Firebase Database
                    if let facilityUsername = self.facility?.username {
                        self.storeImageUrl(logoUrl, forFacility: facilityUsername)
                    }

                    // Proceed with creating or updating the facility
                    self.createOrUpdateFacility(with: logoUrl) {
                        self.finalizeFacilityUpdate()
                    }
                }
            } else {
                // If no new image, use existing logo URL
                createOrUpdateFacility(with: facility?.logoImageName) {
                    self.finalizeFacilityUpdate()
                }
            }
    
        AppData.saveToFile()
    }
    
    private func createOrUpdateFacility(with logoUrl: String?, completion: @escaping () -> Void) {
        // Convert and validate phone number
            guard let phoneNumberInt = Int(facilityPhoneNumberTextField.text ?? "") else {
                presentAlert(title: "Error", message: "Invalid phone number.")
                return
            }

            let username = facilityUsernameTextField.text ?? ""
            let password = facilityPasswordTextField.text ?? ""
            let name = facilityNameTextField.text ?? ""
            let location = facilityLocationTextField.text ?? ""
            let isOpen24Hours = isAlwaysOpenSwitch.isOn
            let facilityType: FacilityType = facilityTypeSC.selectedSegmentIndex == 0 ? .hospital : .lab
            let openingTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: openingTimeDP.date)
            let closingTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: closingTimeDP.date)

            if let facility = self.facility {
                // Updating existing facility
                facility.username = username
                facility.password = password
                facility.name = name
                facility.phoneNumber = phoneNumberInt
                facility.location = location
                facility.isOpen24Hours = isOpen24Hours
                facility.facilityType = facilityType
                facility.openingTime = openingTimeComponents
                facility.closingTime = closingTimeComponents
                facility.logoImageName = logoUrl ?? facility.logoImageName 

                AppData.editFacility(facility: facility)
                
                
            } else {
                // Create a new Facility object
                
                let newFacility = Facility(username: username, password: password, phoneNumber: phoneNumberInt, name: name, location: location, isOpen24Hours: isOpen24Hours, openingTime: openingTimeComponents, closingTime: closingTimeComponents, facilityType: facilityType, logoImageName: logoUrl ?? "defaultLogo.jpeg")
                
                AppData.addFacility(facility: newFacility)
            }
        completion()
        }
    
    private func finalizeFacilityUpdate() {
        //AppData.saveFacilities()
        refreshFacilityList()
        print("Navigating back after facility update")
        navigationController?.popViewController(animated: true)
    }

    
    
    // MARK: - Firebase URL Storage
    func storeImageUrl(_ url: String, forFacility username: String) {
        // Firebase Database reference
        let ref = Database.database().reference()
        ref.child("facilities").child(username).child("logoUrl").setValue(url)
    }

       // MARK: - Firebase URL Retrieval
    func fetchImageUrl(forFacility username: String, completion: @escaping (_ url: String?) -> Void) {
        let ref = Database.database().reference()
        ref.child("facilities").child(username).child("logoUrl").observeSingleEvent(of: .value) { snapshot in
            guard let url = snapshot.value as? String else {
                completion(nil)
                return
            }
            completion(url)
        }
    }

       // MARK: - Load and Display Image
       func loadImage(from url: String, into imageView: UIImageView) {
           guard let imageURL = URL(string: url) else {
               print("Invalid image URL")
               return
           }

           URLSession.shared.dataTask(with: imageURL) { data, response, error in
               guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                     let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                     let data = data, error == nil,
                     let image = UIImage(data: data) else {
                   print("Error fetching image: \(error?.localizedDescription ?? "")")
                   return
               }

               DispatchQueue.main.async {
                   imageView.image = image
               }
           }.resume()
       }
    // MARK: - Image Upload to Firebase Storage
    func uploadImage(_ image: UIImage, completion: @escaping (_ url: String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Could not get JPEG representation of UIImage")
            completion(nil)
            return
        }

        // Create a reference to the Firebase Storage location
        let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).jpg")

        // Upload the image data
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                print("Error during image upload: \(error?.localizedDescription ?? "")")
                completion(nil)
                return
            }

            // Retrieve the download URL
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Error retrieving download URL")
                    completion(nil)
                    return
                }
                // Pass the direct HTTP URL string back to the completion handler
                completion(downloadURL.absoluteString)
            }
        }
        print("done uploading")
    }

    
    
    @objc func facilityLogoTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func facilityIsAlwaysOpen(_ sender: UISwitch) {
        if sender.isOn{
            openingTimeCell.isHidden = true
            closingTimeCell.isHidden = true
        } else {
            openingTimeCell.isHidden = false
            closingTimeCell.isHidden = false
        }
    }
    
    
    func updateCurrentType(){
        currentFacilityType = facilityTypeSC.selectedSegmentIndex == 0 ? .hospital : .lab
    }
    
    
    
}

extension FacilityFormTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
                selectedImage = image
                facilityLogo.image = image
            }
        dismiss(animated: true, completion: nil)
    }
}
