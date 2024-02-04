//
//  SampleData.swift
//  LabCaught
//
//  Created by Fatima ahmed on 05/01/2024.
//

import Foundation

extension AppData{
    // Pre-defined admin user with initial credentials.
    static var admins: [Admin] = [Admin(username: "admin", password: "admin123", department: "IT", firstName: "Alice", lastName: "Russo", phoneNumber: 12345678)]
    
    // Sample patient data for testing purposes.
    static var samplePatients: [Patient] = [
        Patient(username: "sa56", password: "7655", phoneNumber: 33234455, firstName: "Saleh", lastName: "ahmed", DOB: DateComponents(calendar: Calendar.current, year: 2009, month: 1, day:2), CPR: 091000000),
        
        Patient(username: "hessa5", password: "hasoos", phoneNumber: 0909098, firstName: "Hessa", lastName: "Fadhel", DOB: DateComponents(calendar: Calendar.current, year: 2002, month: 1, day:2), CPR: 021176524),
        
        Patient(username: "Fahad22", password: "fahad5454", phoneNumber: 777532424, firstName: "Fahad", lastName: "Ali", DOB: DateComponents(calendar: Calendar.current, year: 2002, month: 1, day:2), CPR: 7720829),
        
        Patient(username: "maryams", password: "1234", phoneNumber: 39993999, firstName: "Maryam", lastName: "Salah", DOB: DateComponents(calendar: Calendar.current, year: 2003, month: 11, day:22), CPR: 031100000),
        
        Patient(username: "fatimaa", password: "3143", phoneNumber: 38883888, firstName: "Fatima", lastName: "Ali", DOB: DateComponents(calendar: Calendar.current, year: 2003, month: 05, day:09), CPR: 030500000),
        
        Patient(username: "khalidk", password: "password1", phoneNumber: 12345678, firstName: "Khalid", lastName: "Khan", DOB: DateComponents(calendar: Calendar.current, year: 2004, month: 7, day:15), CPR: 040715000),
        
            Patient(username: "nooran", password: "pass123", phoneNumber: 98765432, firstName: "Noor", lastName: "Alam", DOB: DateComponents(calendar: Calendar.current, year: 2001, month: 3, day:21), CPR: 010321000),
        
        Patient(username: "Nasser", password: "passwordN", phoneNumber: 55511111, firstName: "Nasser", lastName: "Al-Something", DOB: DateComponents(calendar: Calendar.current, year: 2001, month: 6, day:15), CPR: 010615001),
        
           Patient(username: "Hessa", password: "passwordH", phoneNumber: 55522222, firstName: "Hessa", lastName: "Al-Another", DOB: DateComponents(calendar: Calendar.current, year: 2002, month: 7, day:20), CPR: 020720002),
        
           Patient(username: "Jan", password: "passwordJ", phoneNumber: 55533333, firstName: "Jan", lastName: "Doe", DOB: DateComponents(calendar: Calendar.current, year: 2000, month: 1, day:10), CPR: 000110003),
        
           Patient(username: "Kendall", password: "passwordK", phoneNumber: 55544444, firstName: "Kendall", lastName: "Jenner", DOB: DateComponents(calendar: Calendar.current, year: 1999, month: 11, day:11), CPR: 991111004),
        
           Patient(username: "Selena", password: "passwordS", phoneNumber: 55555555, firstName: "Selena", lastName: "Gomez", DOB: DateComponents(calendar: Calendar.current, year: 1998, month: 7, day:22), CPR: 980722005),
        
           Patient(username: "Taylor", password: "passwordT", phoneNumber: 55566666, firstName: "Taylor", lastName: "Swift", DOB: DateComponents(calendar: Calendar.current, year: 1989, month: 12, day:13), CPR: 891213006),
        
           Patient(username: "Hamad", password: "passwordHm", phoneNumber: 55577777, firstName: "Hamad", lastName: "Al-Hamad", DOB: DateComponents(calendar: Calendar.current, year: 2003, month: 3, day:5), CPR: 030305007),
        
           Patient(username: "Issa", password: "passwordI", phoneNumber: 55588888, firstName: "Issa", lastName: "Al-Issa", DOB: DateComponents(calendar: Calendar.current, year: 1997, month: 5, day:25), CPR: 970525008)
    ]
    
    
    // Facility instances for dummy data.
    static var Facility1 = Facility(username: "Alhilal",
                                    password: "12345",
                                    phoneNumber: 17001700,
                                    name: "Al Hilal Hospital",
                                    location: "Riffa, Bahrain",
                                    isOpen24Hours: true,
                                    openingTime: DateComponents(hour: 8, minute: 0),
                                    closingTime: DateComponents(hour: 8, minute: 0),
                                    facilityType: .hospital,
                                    logoImageName: "AlHilal.png")
    
    static var Facility2 = Facility(username: "Alsalam",
                                    password: "12345",
                                    phoneNumber: 17001700,
                                    name: "Al Salam Hospital",
                                    location: "Muharraq, Bahrain",
                                    isOpen24Hours: true,
                                    openingTime: DateComponents(hour: 8, minute: 0),
                                    closingTime: DateComponents(hour: 8, minute: 0),
                                    facilityType: .hospital,
                                    logoImageName: "AlSalam.png")
    
    static var Facility3 = Facility(username: "shifa",
                                    password: "12345", phoneNumber: 17288000,
                                    name: "Shifa Al Jazeera Hospital",
                                    location: "Manama, Bahrain",
                                    isOpen24Hours: true,
                                    openingTime: DateComponents(hour: 8, minute: 0),
                                    closingTime: DateComponents(hour: 8, minute: 0),
                                    facilityType: .hospital,
                                    logoImageName: "ShifaAlJazeera.png")
    
    static var Facility4 = Facility(username: "KHamadUni",
                                    password: "12345",
                                    phoneNumber: 17444444,
                                    name: "King Hamad University",
                                    location: "Busaiteen, Bahrain",
                                    isOpen24Hours: true,
                                    openingTime: DateComponents(hour: 8, minute: 0),
                                    closingTime: DateComponents(hour: 20, minute: 0),
                                    facilityType: .hospital,
                                    logoImageName: "KingHamadUniversityHospital .jpeg")
    
    static var Facility5 = Facility(username: "MedicalLabortary",
                                    password: "12345",
                                    phoneNumber: 17255522,
                                    name: "Bahrain medical labortary",
                                    location: "Salmaniya, Bahrain",
                                    isOpen24Hours: true,
                                    openingTime: DateComponents(hour: 7, minute: 0),
                                    closingTime: DateComponents(hour: 17, minute: 0),
                                    facilityType: .lab,
                                    logoImageName: "BahrainMedicalLaboratory.jpeg")
    
    static var Facility6 = Facility(username: "ThyrocareGulf",
                                    password: "12345",
                                    phoneNumber: 66004000,
                                    name: "Thyrocare Gulf Laboratories",
                                    location: "Sanabis, Bahrain",
                                    isOpen24Hours: false,
                                    openingTime: DateComponents(hour: 9, minute: 0),
                                    closingTime: DateComponents(hour: 17, minute: 0),
                                    facilityType: .lab,
                                    logoImageName: "ThyrocareGulfLaboratories.jpeg")
    
    static var Facility7 = Facility(username: "AlKindi",
                                        password: "12345",
                                        phoneNumber: 17240444,
                                        name: "Al Kindi Hospital",
                                        location: "Manama, Bahrain",
                                        isOpen24Hours: true,
                                        openingTime: DateComponents(hour: 8, minute: 0),
                                        closingTime: DateComponents(hour: 20, minute: 0),
                                        facilityType: .hospital,
                                        logoImageName: "AlKindiHospital.png")
        
        static var Facility8 = Facility(username: "AlNafees",
                                        password: "12345",
                                        phoneNumber: 17828282,
                                        name: "Ibn Al-Nafees Hospital",
                                        location: "Manama, Bahrain",
                                        isOpen24Hours: true,
                                        openingTime: DateComponents(hour: 8, minute: 0),
                                        closingTime: DateComponents(hour: 20, minute: 0),
                                        facilityType: .hospital,
                                        logoImageName: "IbnAlNafeesHospital.png")
        
        static var Facility9 = Facility(username: "BlossomMedical",
                                        password: "12345",
                                        phoneNumber: 17179316,
                                        name: "Blossom Medical",
                                        location: "Isa Town, Bahrain",
                                        isOpen24Hours: false,
                                        openingTime: DateComponents(hour: 7, minute: 0),
                                        closingTime: DateComponents(hour: 22, minute: 0),
                                        facilityType: .lab,
                                        logoImageName: "BlossomMedical .png")
        
        static var Facility10 = Facility(username: "AsterClinic",
                                        password: "12345",
                                        phoneNumber: 17711811,
                                        name: "Aster Clinic",
                                        location: "Sanad, Bahrain",
                                        isOpen24Hours: false,
                                        openingTime: DateComponents(hour: 7, minute: 0),
                                        closingTime: DateComponents(hour: 23, minute: 0),
                                        facilityType: .lab,
                                        logoImageName: "AsterClinic.jpeg")
        
        static var Facility11 = Facility(username: "AlResalah",
                                        password: "12345",
                                        phoneNumber: 17680088,
                                        name: "Al Resalah Medical Center",
                                        location: "Isa Town, Bahrain",
                                        isOpen24Hours: true,
                                        openingTime: DateComponents(hour: 8, minute: 0),
                                        closingTime: DateComponents(hour: 20, minute: 0),
                                        facilityType: .lab,
                                        logoImageName: "AlResalahMedicalCenter.jpeg")
        
        static var Facility12 = Facility(username: "AlRayan",
                                        password: "12345",
                                        phoneNumber: 17495500,
                                        name: "Al Rayan Medical Complex",
                                        location: "Riffa, Bahrain",
                                        isOpen24Hours: true,
                                        openingTime: DateComponents(hour: 8, minute: 0),
                                        closingTime: DateComponents(hour: 20, minute: 0),
                                        facilityType: .lab,
                                        logoImageName: "AlRayanMedicalComplex.jpeg")
    
    static var Facility13 = Facility(username: "SpecialistHospital",
                                    password: "12345",
                                    phoneNumber: 17812222,
                                    name: "Bahrain Specialist Hospital Laboratory",
                                    location: "Juffair, Bahrain",
                                    isOpen24Hours: false,
                                    openingTime: DateComponents(hour: 8, minute: 0),
                                    closingTime: DateComponents(hour: 16, minute: 0),
                                    facilityType: .lab,
                                    logoImageName: "BahrainSpecialistLaboratory.jpeg")
    
    static var Facility14 = Facility(username: "ExpressMed",
                                    password: "12345",
                                    phoneNumber: 77298888,
                                    name: "ExpressMed Laboratories",
                                    location: "Zinj, Bahrain",
                                    isOpen24Hours: false,
                                    openingTime: DateComponents(hour: 8, minute: 0),
                                    closingTime: DateComponents(hour: 20, minute: 0),
                                    facilityType: .lab,
                                    logoImageName: "ExpressMedLaboratories.jpeg")
    
    static var Facility15 = Facility(username: "AlAmal",
                                    password: "12345",
                                    phoneNumber: 17602602,
                                    name: "Al Amal Hospital",
                                    location: "Buri, Bahrain",
                                    isOpen24Hours: true,
                                    openingTime: DateComponents(hour: 8, minute: 0),
                                    closingTime: DateComponents(hour: 20, minute: 0),
                                    facilityType: .hospital,
                                    logoImageName: "AlAmalHospital.png")
        
        // Array of sample facilities.
        static var sampleFacilities: [Facility] = [Facility1, Facility2, Facility3, Facility4, Facility5, Facility6, Facility7, Facility8, Facility9, Facility10, Facility11, Facility12, Facility13, Facility14, Facility15] {
        didSet {
            //saveFacilities() // Save facilities when the array is updated.
        }
    }

    // Test data for Alhilal Hospital.
    static var test1H = Test(name: "Hemoglobin A1C", cost: "3", describtion: "Measures average blood glucose levels over the past 3 months, used to monitor diabetes.", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[0])
    static var test2H = Test(name: "Renal Function Panel", cost: "5", describtion: "Assesses kidney function by testing substances like creatinine and urea.", insrtuctions: "Blood sample required. Stay hydrated and follow any specific pre-test instructions.", facility: sampleFacilities[0])
    static var test3H = Test(name: "Stress ECG", cost: "2", describtion: "Evaluates heart function under stress conditions, often involving physical exercise.", insrtuctions: "Wear comfortable clothing and shoes suitable for exercise. Avoid eating a heavy meal before the test.", facility: sampleFacilities[0])
    static var test4H = Test(name: "Cholesterol Panel", cost: "7", describtion: "Measures different types of cholesterol and triglycerides to assess heart disease risk.", insrtuctions: "Fasting for 9-12 hours prior to the test is typically required.", facility: sampleFacilities[0])
    static var test5H = Test(name: "Cholesterol Panel", cost: "7", describtion: "Measures different types of cholesterol and triglycerides to assess heart disease risk.", insrtuctions: "Fasting for 9-12 hours prior to the test is typically required.", facility: sampleFacilities[0])
    static var test6H = Test(name: "Liver Enzyme", cost: "8", describtion: "Measures enzymes and proteins to evaluate liver health.", insrtuctions: "Blood sample required. Fasting may be necessary.", facility: sampleFacilities[0])
    static var test7H = Test(name: "Electrolyte Panel", cost: "5", describtion: "Assesses the balance of key electrolytes like sodium, potassium, and chloride.", insrtuctions: "Blood sample needed. Stay hydrated; no other preparation needed.", facility: sampleFacilities[0])
    static var test8H = Test(name: "Uric Acid", cost: "8", describtion: "Measures uric acid in the blood, helping diagnose gout and kidney health.", insrtuctions: "Blood sample required. Avoid foods high in purines before the test.", facility: sampleFacilities[0])

    
    // Test data for AlSalam Hospital.
    static var test1S = Test(name: "Lipid Profile",cost: "6",describtion:"Assesses levels of cholesterol and triglycerides.",insrtuctions: "Fasting for 9-12 hours before the test.",facility: sampleFacilities[1])
        static var test2S = Test(name: "Blood Glucose Level",cost: "9",describtion: "Measures the concentration of glucose in the blood.",insrtuctions: "Fasting for 8 hours before the test is usually required.",facility: sampleFacilities[1])
        static var test3S = Test(name: "Blood Pressure Check",cost: "1",describtion: "Measures the pressure of blood in the arteries.",insrtuctions: "Relax for a few minutes before the test; avoid caffeine or exercise beforehand.",facility: sampleFacilities[1])
        static var test4S = Test(name: "Complete Blood Count",cost: "4",describtion: "Evaluates overall blood health, analyzing various types of blood cells.",insrtuctions: "No special preparation needed.",facility: sampleFacilities[1])
        static var test5S = Test(name: "Thyroid Function",cost: "3",describtion: "Assesses thyroid hormone levels to check thyroid gland function.",insrtuctions: "Typically no fasting required; best taken in the morning.",facility: sampleFacilities[1])
    static var test6S = Test(name: "Vitamin D Level",cost: "7",describtion: "Measures the level of Vitamin D, crucial for bone health.",insrtuctions: "No special preparation needed.",facility: sampleFacilities[1])
    
    // Test data for Shifaa Aljazeera Hospital.
    static var test1Shifa = Test(name: "Aerobic Capacity Test", cost: "5", describtion: "Measures cardiovascular fitness through exercises.", insrtuctions: "Wear comfortable clothing and shoes. Avoid heavy meals before the test.", facility: sampleFacilities[2])
       static var test2Shifa = Test(name: "Body Composition Analysis", cost: "6", describtion: "Assesses body fat percentage and muscle distribution.", insrtuctions: "May require wearing minimal clothing; avoid eating or drinking a few hours before the test.", facility: sampleFacilities[2])
       static var test3Shifa = Test(name: "Bone Density Scan", cost: "14", describtion: "Evaluates bone mineral density for osteoporosis risk.", insrtuctions: "No metal objects on the body during the scan. Inform the technician if pregnant or possibly pregnant.", facility: sampleFacilities[2])
       static var test4Shifa = Test(name: "Liver Function Test", cost: "15", describtion: "Assesses the health of the liver.", insrtuctions: "Blood sample required. Fasting may be advised.", facility: sampleFacilities[2])
       static var test5Shifa = Test(name: "H. Pylori Test", cost: "9", describtion: "Detects H. pylori bacteria, associated with ulcers.", insrtuctions: "Blood, stool, or breath sample required. Specific preparation depends on the test type.", facility: sampleFacilities[2])
       static var test6Shifa = Test(name: "Gluten Sensitivity Test", cost: "10", describtion: "Tests for gluten intolerance or celiac disease.", insrtuctions: "Blood sample required. Maintain normal diet including gluten before the test.", facility: sampleFacilities[2])
    
    //Test data for King Hamad Hospital
    static var test1KHUH = Test(name: "Clinical Urologist Examination", cost: "15", describtion: "A specialized examination focusing on the urinary tract and male reproductive organs.", insrtuctions: "No specific preparation required, but be ready to discuss any symptoms or concerns.", facility: sampleFacilities[3])
    static var test2KHUH = Test(name: "Electrocardiogram (ECG)", cost: "22", describtion: "Records the electrical activity of the heart to detect heart problems.", insrtuctions: "Lie still during the test; avoid cold lotions or oils on your chest.", facility: sampleFacilities[3])
    static var test3KHUH = Test(name: "Chest X-Ray", cost: "30", describtion: "Provides images of the chest, including lungs, heart, and bones.", insrtuctions: "Remove any jewelry and wear a hospital gown; inform the technician if you might be pregnant.", facility: sampleFacilities[3])
    static var test4KHUH = Test(name: "Complete Physical Examination", cost: "25", describtion: "A thorough examination assessing overall health.", insrtuctions: "Wear comfortable clothing; be prepared to discuss your medical history.", facility: sampleFacilities[3])
    static var test5KHUH = Test(name: "Pap Smear", cost: "18", describtion: "Screens for cervical cancer and certain vaginal or uterine infections.", insrtuctions: "Avoid intercourse, douching, or using vaginal medications for 24 hours before the test.", facility: sampleFacilities[3])
    static var test6KHUH = Test(name: "Abdominal Ultrasound (US)", cost: "35", describtion: "Uses sound waves to create images of abdominal organs.", insrtuctions: "Fast for 8-12 hours before the exam; only water is allowed.", facility: sampleFacilities[3])
    static var test7KHUH = Test(name: "Digital Mammography", cost: "40", describtion: "An X-ray of the breast used to detect breast cancer.", insrtuctions: "Don’t wear deodorant or powder on the day of the test; wear a two-piece outfit for convenience.", facility: sampleFacilities[3])
    static var test8KHUH = Test(name: "Bone Marrow Density Scan", cost: "46", describtion: "Measures bone density and assesses the risk of osteoporosis.", insrtuctions: "Wear comfortable clothing without metal fasteners; inform your doctor if you’ve recently had a barium exam or been injected with a contrast material.", facility: sampleFacilities[3])
    static var test9KHUH = Test(name: "Pelvic Ultrasound (US Pelvis)", cost: "28", describtion: "Visualizes pelvic organs and structures, including the uterus and ovaries.", insrtuctions: "You may need to have a full bladder; drink water before the exam and avoid urinating.", facility: sampleFacilities[3])
    static var test10KHUH = Test(name: "Lung Function Test", cost: "33", describtion: "Measures how well you breathe and how effective your lungs bring oxygen to your body.", insrtuctions: "Wear loose clothing; avoid heavy meals and smoking before the test.", facility: sampleFacilities[3])

    
    // Test data for Bahrain medical Lab.
    static var test1BHlab = Test(name: "ABO/Rh Blood Typing", cost: "6", describtion: "Determines blood group (A, B, AB, or O) and Rh factor (positive or negative).", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[4])
    static var test2BHlab = Test(name: "Bacterial Culture, Aerobic, Urine", cost: "11", describtion: "Identifies bacterial infections in the urine.", insrtuctions: "Midstream urine sample needed. Follow proper collection techniques to avoid contamination.", facility: sampleFacilities[4])
    static var test3BHlab = Test(name: "Protein, Total, 24 Hour, Urine (PTU)", cost: "8", describtion: "Measures the amount of protein excreted in urine over 24 hours, assessing kidney function.", insrtuctions: "Collect all urine over a 24-hour period in a provided container. Store the container in a cool place during the collection period.", facility: sampleFacilities[4])
    static var test4BHlab = Test(name: "Liver Profile, Serum", cost: "13", describtion: "A panel of tests to evaluate liver function, including enzymes and bilirubin.", insrtuctions: "Blood sample required. Fasting for 8-12 hours may be necessary.", facility: sampleFacilities[4])
    static var test5BHlab = Test(name: "Uric Acid, Body Fluid", cost: "5", describtion: "Measures the level of uric acid in body fluids to assess gout or kidney stones.", insrtuctions: "Sample of body fluid (like joint fluid) needed. The specific preparation depends on the fluid being collected.", facility: sampleFacilities[4])

    //Test data for Thyrocare Gulf Laboratories
    static var test1Thy = Test(name: "Ferritin", cost: "10", describtion: "Indicates the amount of iron stored in your body, useful in diagnosing anemia.", insrtuctions: "Blood sample required. Inform your doctor about any iron supplements.", facility: sampleFacilities[5])
        static var test2Thy = Test(name: "Antinuclear Antibodies (ANA)", cost: "8", describtion: "Detects ANA in your blood, often used to diagnose autoimmune disorders.", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[5])
        static var test3Thy = Test(name: "Erythrocyte Sedimentation Rate (ESR)", cost: "11", describtion: "Measures the rate at which red blood cells settle, indicating inflammation.", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[5])
        static var test4Thy = Test(name: "Magnesium", cost: "11", describtion: "Tests magnesium levels in the blood, important for muscle and nerve function.", insrtuctions: "Blood sample required. Avoid magnesium supplements before the test.", facility: sampleFacilities[5])
        static var test5Thy = Test(name: "Testosterone", cost: "10", describtion: "Measures testosterone levels, important for diagnosing various health conditions.", insrtuctions: "Blood sample required. Test usually done in the morning.", facility: sampleFacilities[5])
        static var test6Thy = Test(name: "Iron Deficiency Panel (3 Tests)", cost: "7", describtion: "Includes tests like serum iron, ferritin, and total iron-binding capacity (TIBC) to evaluate iron status.", insrtuctions: "Blood sample required. Fasting may be needed.", facility: sampleFacilities[5])
        static var test7Thy = Test(name: "Complete Blood Count (CBC)", cost: "11", describtion: "Provides a comprehensive count of different types of blood cells.", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[5])
    
    //Test data for Alkindi Hospital
    static var test1Kindi = Test(name: "Complete Blood Count", cost: "11", describtion: "Measures the levels of different blood cells, indicating overall health and detecting a range of disorders.", insrtuctions: "Provide a blood sample. No special preparation required.", facility: sampleFacilities[6])
        static var test2Kindi = Test(name: "Lipid Profile", cost: "9", describtion: "Assesses the levels of cholesterol and triglycerides to evaluate heart disease risk.", insrtuctions: "Blood sample required, usually after fasting for 9-12 hours.", facility: sampleFacilities[6])
        static var test3Kindi = Test(name: "Fasting Blood Sugar", cost: "11", describtion: "Measures blood glucose levels after a period of fasting, used to diagnose and monitor diabetes.", insrtuctions: "Fast for at least 8 hours before the test. Only water is allowed.", facility: sampleFacilities[6])
        static var test4Kindi = Test(name: "Blood Pressure Check", cost: "13", describtion: "Measures the pressure in the arteries as the heart pumps, essential for heart health monitoring.", insrtuctions: "Rest for 5 minutes before the test. Avoid caffeine and exercise 30 minutes prior.", facility: sampleFacilities[6])
        static var test5Kindi = Test(name: "Liver Function Test", cost: "14", describtion: "Evaluates the health of the liver by measuring enzymes, proteins, and bilirubin.", insrtuctions: "Blood sample required. Avoid alcohol and certain medications as advised by your doctor.", facility: sampleFacilities[6])
        static var test6Kindi = Test(name: "Renal Function Test", cost: "12", describtion: "Assesses kidney function by measuring various substances in the blood.", insrtuctions: "Provide a blood sample. Stay hydrated. No fasting necessary.", facility: sampleFacilities[6])
        static var test7Kindi = Test(name: "Thyroid Function Test", cost: "9", describtion: "Measures thyroid hormone levels to assess thyroid function.", insrtuctions: "Blood sample needed. Ideally taken in the morning.", facility: sampleFacilities[6])
    
    //Test data for Alnafees Hospital
    static var test1Naf = Test(name: "Hemoglobin A1C", cost: "11", describtion: "Evaluates average blood sugar levels over 3 months.", insrtuctions: "Blood sample required. No fasting necessary.", facility: sampleFacilities[7])
        static var test2Naf = Test(name: "Complete Metabolic Panel (CMP)", cost: "8", describtion: "Checks kidney and liver function, electrolyte balance, and blood glucose.", insrtuctions: "Blood sample needed. Fasting for 8-12 hours recommended.", facility: sampleFacilities[7])
        static var test3Naf = Test(name: "Blood Urea Nitrogen (BUN)", cost: "8", describtion: "Assesses kidney function by measuring urea nitrogen in the blood.", insrtuctions: "Blood sample required. Stay hydrated; fasting isn't necessary.", facility: sampleFacilities[7])
        static var test4Naf = Test(name: "Creatinine", cost: "7", describtion: "Tests kidney function by measuring creatinine levels.", insrtuctions: "Blood sample needed. No specific preparation required.", facility: sampleFacilities[7])
        static var test5Naf = Test(name: "Prostate-Specific Antigen (PSA)", cost: "13", describtion: "Screens for prostate cancer by measuring PSA levels.", insrtuctions: "Blood sample required. Avoid ejaculation 24 hours before the test.", facility: sampleFacilities[7])
        static var test6Naf = Test(name: "Vitamin D Level", cost: "16", describtion: "Determines Vitamin D status, important for bone health.", insrtuctions: "Blood sample needed. No special preparation required.", facility: sampleFacilities[7])
        static var test7Naf = Test(name: "Calcium Level", cost: "17", describtion: "Measures calcium in the blood, essential for bones and teeth.", insrtuctions: "Blood sample required. Fasting may be advised.", facility: sampleFacilities[7])
        static var test8Naf = Test(name: "Electrolyte Panel", cost: "12", describtion: "Evaluates sodium, potassium, chloride levels in the blood.", insrtuctions: "Blood sample needed. Stay hydrated; no other preparation needed.", facility: sampleFacilities[7])
        static var test9Naf = Test(name: "Thyroid-Stimulating Hormone (TSH)", cost: "13", describtion: "Assesses thyroid function by measuring TSH levels.", insrtuctions: "Blood sample required. Typically taken in the morning.", facility: sampleFacilities[7])
    
    
    //Test data for Blossom Lab
    static var test1Blos = Test(name: "C-Reactive Protein", cost: "7.5", describtion: "Measures the level of CRP in the blood to detect inflammation or infection.", insrtuctions: "Requires a blood sample. No special preparation needed. Avoid strenuous exercise before the test.", facility: sampleFacilities[8])
    static var test2Blos = Test(name: "Complete Metabolic Panel", cost: "6", describtion: "Evaluates overall health, including kidney and liver function, electrolyte levels, and blood glucose.", insrtuctions: "Blood sample required. Fasting for 8-12 hours before the test is usually necessary.", facility: sampleFacilities[8])
    static var test3Blos = Test(name: "Bone Density Scan", cost: "11", describtion: "Assesses bone mineral density to check for osteoporosis or other bone health issues.", insrtuctions: "No metal objects on the body during the scan. Inform the technician if pregnant or possibly pregnant.", facility: sampleFacilities[8])
    static var test4Blos = Test(name: "Serum Calcium", cost: "9", describtion: "Measures calcium levels in the blood to assess bone health and metabolic functions.", insrtuctions: "Blood sample required. Fasting may be advised. Avoid calcium supplements before the test.", facility: sampleFacilities[8])
    static var test5Blos = Test(name: "Spirometry Test", cost: "6", describtion: "Evaluates lung function by measuring air inhalation and exhalation.", insrtuctions: "Wear comfortable clothing. Avoid heavy meals and smoking before the test. Follow breathing instructions during the test.", facility: sampleFacilities[8])
    static var test6Blos = Test(name: "Erythrocyte Sedimentation Rate", cost: "12", describtion: "Measures how quickly red blood cells settle in a tube, indicating inflammation.", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[8])
    
    //Test data for Aster clinic
    static var test1Ast = Test(name: "Complete Blood Count (CBC)", cost: "11", describtion: "Measures various types of blood cells to assess overall health and detect a range of disorders.", insrtuctions: "A blood sample is required. No special preparation is needed.", facility: sampleFacilities[9])
        static var test2Ast = Test(name: "Vitamin D Test", cost: "7", describtion: "Determines the level of Vitamin D, essential for bone health and immune function.", insrtuctions: "Blood sample required. No fasting necessary.", facility: sampleFacilities[9])
        static var test3Ast = Test(name: "Iron Deficiency Profile", cost: "14", describtion: "Includes tests like serum iron, ferritin, and TIBC to evaluate iron status in the body.", insrtuctions: "Blood sample required. Fasting for a few hours might be recommended.", facility: sampleFacilities[9])
        static var test4Ast = Test(name: "Lipid Profile", cost: "11", describtion: "Assesses levels of cholesterol and triglycerides in the blood, indicators of heart health.", insrtuctions: "Fasting for 9-12 hours prior to the test is typically required.", facility: sampleFacilities[9])
        static var test5Ast = Test(name: "Thyroid Function Test (TFT)", cost: "12", describtion: "Measures thyroid hormone levels, crucial for diagnosing thyroid disorders.", insrtuctions: "Blood sample needed, usually with no special preparation.", facility: sampleFacilities[9])
        static var test6Ast = Test(name: "Liver Profile (LFT)", cost: "10", describtion: "Evaluates liver health by measuring enzymes, proteins, and bilirubin in the blood.", insrtuctions: "You may need to fast for a few hours before the test.", facility: sampleFacilities[9])
        static var test7Ast = Test(name: "Renal Profile (Kidney Function Test)", cost: "9", describtion: "Assesses kidney function by testing for substances like urea, creatinine, and electrolytes.", insrtuctions: "Blood sample required. Stay hydrated and follow any specific pre-test instructions.", facility: sampleFacilities[9])
        static var test8Ast = Test(name: "Vitamin B12 Test", cost: "6", describtion: "Measures the level of vitamin B12, important for nerve function and healthy blood cells.", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[9])
        static var test9Ast = Test(name: "Ferritin", cost: "8", describtion: "Checks the stored iron in the body, helping to diagnose anemia or iron overload.", insrtuctions: "Blood sample required. Inform your doctor about any supplements or medications.", facility: sampleFacilities[9])
    
    //Test data for Al Resalah Medical Center
    static var test1Res = Test(name: "Kidney Profile", cost: "14", describtion: "Assesses kidney function by measuring substances like urea, creatinine, and electrolytes.", insrtuctions: "Blood sample required. No special preparation, but stay hydrated.", facility: sampleFacilities[10])
        static var test2Res = Test(name: "Liver Profile", cost: "14", describtion: "Evaluates liver health by testing enzymes, proteins, and bilirubin levels.", insrtuctions: "Blood sample required. Fasting for several hours may be necessary.", facility: sampleFacilities[10])
        static var test3Res = Test(name: "Complete Blood Count (CBC)", cost: "8", describtion: "Measures different types of cells in the blood to assess overall health and detect disorders.", insrtuctions: "Blood sample required. No fasting or special preparation needed.", facility: sampleFacilities[10])
        static var test4Res = Test(name: "Vitamin D", cost: "12", describtion: "Determines the level of Vitamin D, important for bone health and immune function.", insrtuctions: "Blood sample required. No fasting necessary.", facility: sampleFacilities[10])
        static var test5Res = Test(name: "Iron", cost: "13", describtion: "Measures the level of iron in the blood, crucial for forming healthy red blood cells.", insrtuctions: "Blood sample required. Fasting may be advised.", facility: sampleFacilities[10])
        static var test6Res = Test(name: "Zinc", cost: "11", describtion: "Tests for zinc levels in the body, important for immune function and wound healing.", insrtuctions: "Blood sample required. Avoid taking zinc supplements before the test.", facility: sampleFacilities[10])
        static var test7Res = Test(name: "Lipids Profile", cost: "9", describtion: "Checks levels of cholesterol and triglycerides in the blood to assess heart disease risk.", insrtuctions: "Blood sample required. Fast for 9-12 hours prior to the test.", facility: sampleFacilities[10])
        static var test8Res = Test(name: "Urine Analysis", cost: "11", describtion: "Examines urine for various substances to diagnose a range of conditions.", insrtuctions: "Provide a midstream urine sample in a sterile container. Follow proper collection methods.", facility: sampleFacilities[10])
    
    //Test data for Alrayan Hospital
    static var test1Ray = Test(name: "Vitamin D", cost: "7", describtion: "Measures the level of Vitamin D, crucial for bone health and immune function.", insrtuctions: "Blood sample required. No fasting necessary.", facility: sampleFacilities[11])
        static var test2Ray = Test(name: "Calcium (Ca)", cost: "7", describtion: "Assesses calcium levels in the blood, important for bone health and muscle function.", insrtuctions: "Blood sample required. Fasting may be advised.", facility: sampleFacilities[11])
        static var test3Ray = Test(name: "Iron (Fe)", cost: "7", describtion: "Measures the amount of iron in the blood, essential for red blood cell production.", insrtuctions: "Blood sample required. Fasting for a few hours might be recommended.", facility: sampleFacilities[11])
        static var test4Ray = Test(name: "Vitamin B12", cost: "5", describtion: "Evaluates Vitamin B12 levels, important for nerve function and blood cell formation.", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[11])
        static var test5Ray = Test(name: "Ferritin (for Iron Deficiency)", cost: "7", describtion: "Indicates the amount of stored iron, useful in diagnosing iron deficiency or overload.", insrtuctions: "Blood sample required. Inform about any iron supplements or medications.", facility: sampleFacilities[11])
        static var test6Ray = Test(name: "Thyroid Function (TSH Test)", cost: "8", describtion: "Measures thyroid-stimulating hormone (TSH) to assess thyroid function.", insrtuctions: "Blood sample needed. Best taken in the morning.", facility: sampleFacilities[11])
        static var test7Ray = Test(name: "Zinc", cost: "8", describtion: "Tests for zinc levels, important for immune function and wound healing.", insrtuctions: "Blood sample required. Avoid taking zinc supplements before the test.", facility: sampleFacilities[11])
        static var test8Ray = Test(name: "Uric Acid", cost: "6", describtion: "Measures uric acid levels, useful in diagnosing gout and kidney stones.", insrtuctions: "Blood sample required. Avoid foods high in purines before the test.", facility: sampleFacilities[11])
        static var test9Ray = Test(name: "Hemoglobin", cost: "8", describtion: "Measures hemoglobin levels, essential for diagnosing anemia.", insrtuctions: "Blood sample required. No special preparation needed.", facility: sampleFacilities[11])
    
    //Test data for Specialist Hospital
    static var test1bhSp = Test(name: "Complete Blood Count (CBC)", cost: "10", describtion: "Measures various components of blood, including red and white blood cells, to assess overall health.", insrtuctions: "No specific preparation needed.", facility: sampleFacilities[12])
        static var test2bhSp = Test(name: "Thyroid Function Test", cost: "5", describtion: "Evaluates thyroid gland performance by measuring hormone levels.", insrtuctions: "Fast for 8-10 hours prior. Avoid thyroid medications before the test.", facility: sampleFacilities[12])
        static var test3bhSp = Test(name: "Vitamin D Test", cost: "9", describtion: "Determines Vitamin D levels, important for bone health and immune function.", insrtuctions: "No fasting required. Continue regular diet.", facility: sampleFacilities[12])
        static var test4bhSp = Test(name: "Blood Glucose Test", cost: "6", describtion: "Measures blood sugar levels to assess for diabetes or prediabetes.", insrtuctions: "Fast for 8-12 hours before the test.", facility: sampleFacilities[12])
        static var test5bhSp = Test(name: "Lipid Profile", cost: "5", describtion: "Assesses the levels of various types of fat in the blood, important for heart health.", insrtuctions: "Fast for 12 hours prior to the test.", facility: sampleFacilities[12])
        static var test6bhSp = Test(name: "Liver Function Test", cost: "7", describtion: "Evaluates liver health by measuring enzymes, proteins, and substances produced by the liver.", insrtuctions: "Fast for 8-12 hours before the test.", facility: sampleFacilities[12])
        static var test7bhSp = Test(name: "Vitamin B12 Test", cost: "8", describtion: "Measures the level of Vitamin B12 in the blood, crucial for nerve function and blood cell production.", insrtuctions: "No specific preparation required. Continue normal diet.", facility: sampleFacilities[12])
    
    //Test data for Express Med
    static var test1Exp = Test(name: "Complete Blood Count (CBC)", cost: "10", describtion: "Assesses overall health by measuring various components of blood.", insrtuctions: "No fasting required. Regular diet and activities can be maintained.", facility: sampleFacilities[13])
        static var test2Exp = Test(name: "Thyroid Function Test", cost: "11", describtion: "Evaluates thyroid hormone levels to check thyroid gland function.", insrtuctions: "Fast for 8-10 hours before the test. Avoid thyroid medications temporarily if instructed by your doctor.", facility: sampleFacilities[13])
        static var test3Exp = Test(name: "Vitamin D Test", cost: "12", describtion: "Measures Vitamin D levels, important for bone health and immune function.", insrtuctions: "No special preparation required. Continue regular diet.", facility: sampleFacilities[13])
        static var test4Exp = Test(name: "Blood Glucose Test", cost: "7", describtion: "Measures blood sugar levels to assess for diabetes or prediabetes.", insrtuctions: "Fast for 8-12 hours before the test.", facility: sampleFacilities[13])
        static var test5Exp = Test(name: "Lipid Profile", cost: "7", describtion: "Assesses blood fat levels, including cholesterol, important for heart health.", insrtuctions: "Fast for 12 hours prior to the test.", facility: sampleFacilities[13])
        static var test6Exp = Test(name: "Liver Function Test", cost: "9", describtion: "Evaluates liver health by measuring enzymes and proteins produced by the liver.", insrtuctions: "Fast for 8-12 hours before the test.", facility: sampleFacilities[13])
        static var test7Exp = Test(name: "Vitamin B12 Test", cost: "13", describtion: "Determines Vitamin B12 levels, essential for nerve function and blood cell production.", insrtuctions: "No specific preparation required. Maintain your regular diet.", facility: sampleFacilities[13])
    
    //Test data for Alamal Hospital
    static var test1Amal = Test(name: "Complete Blood Count (CBC)", cost: "6", describtion: "Measures various blood components to assess general health.", insrtuctions: "No special preparation required.", facility: sampleFacilities[14])
        static var test2Amal = Test(name: "Liver Function Test", cost: "7", describtion: "Evaluates the health and functionality of the liver.", insrtuctions: "Fast for 8-12 hours before the test.", facility: sampleFacilities[14])
        static var test3Amal = Test(name: "Vitamin B12 Test", cost: "7", describtion: "Checks Vitamin B12 levels, essential for nerve health and blood formation.", insrtuctions: "No fasting required. Continue normal diet.", facility: sampleFacilities[14])
        static var test4Amal = Test(name: "Lipid Profile", cost: "5", describtion: "Assesses levels of different types of fats in the blood.", insrtuctions: "Fast for 12 hours before the test.", facility: sampleFacilities[14])
        static var test5Amal = Test(name: "Blood Glucose Test", cost: "8", describtion: "Measures blood sugar levels to screen for diabetes.", insrtuctions: "Fast for 8-12 hours prior to the test.", facility: sampleFacilities[14])
        static var test6Amal = Test(name: "Thyroid Function Test", cost: "4", describtion: "Tests thyroid hormone levels to evaluate thyroid gland function.", insrtuctions: "Fast for 8-10 hours before the test; avoid thyroid medications as advised by your doctor.", facility: sampleFacilities[14])
        static var test7Amal = Test(name: "Vitamin D Test", cost: "8", describtion: "Determines Vitamin D levels, important for bone health and immune function.", insrtuctions: "No specific preparation required; maintain regular diet.", facility: sampleFacilities[14])
    
    
    
    
    
    static var tests: [Test] = [test1H,test2H, test3H, test4H, test5H, test6H,test7H, test8H, test1S, test2S, test3S, test4S, test5S,test6S, test1Shifa, test2Shifa, test3Shifa,test4Shifa,test5Shifa,test6Shifa, test1BHlab,test2BHlab,test3BHlab,test4BHlab,test5BHlab, test1Blos,test2Blos,test3Blos,test4Blos,test5Blos,test6Blos,test1KHUH,test2KHUH,test3KHUH,test4KHUH,test5KHUH,test6KHUH, test7KHUH,test8KHUH,test9KHUH,test10KHUH,test1Thy,test2Thy,test3Thy,test4Thy,test5Thy,test6Thy,test7Thy,test1Kindi,test2Kindi,test3Kindi,test4Kindi,test5Kindi,test6Kindi,test7Kindi,test1Naf,test2Naf,test3Naf,test4Naf,test5Naf,test6Naf,test7Naf,test8Naf,test9Naf,test1Ast,test2Ast,test3Ast,test4Ast,test5Ast,test6Ast,test7Ast,test8Ast,test9Ast,test1Res,test2Res,test3Res,test4Res,test5Res,test6Res,test7Res,test8Res,test1Ray,test2Ray,test3Ray,test4Ray,test5Ray,test6Ray,test7Ray,test8Ray,test9Ray,test1bhSp,test2bhSp,test3bhSp,test4bhSp,test5bhSp,test6bhSp,test7bhSp,test1Exp,test2Exp,test3Exp,test4Exp,test5Exp,test6Exp,test7Exp,test1Amal,test2Amal,test3Amal,test4Amal,test5Amal,test6Amal,test7Amal]
    
    
    // Packages data for Alhilal Hospital
    static var package1H = Packages(name: "Vitality Screening Package", cost: "30", describtion: " This package is designed to assess blood sugar control and kidney health.", insrtuctions: " For the Hemoglobin A1C test, no special preparation is needed. The Renal Function Panel may require fasting, so check with your healthcare provider.", packageIncludes: [test1H, test2H], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 6, day:2), facility: sampleFacilities[0])
    static var package2H = Packages(name: "Cardio Care Package", cost: "58", describtion: "Focuses on heart health by evaluating cardiovascular function and cholesterol levels.", insrtuctions: "Wear comfortable clothing for the Stress ECG, which may involve physical exercise. Fasting for 9-12 hours before the Cholesterol Panel test is typically required.", packageIncludes: [test3H, test4H], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day:31), facility: sampleFacilities[0])
    
    // Packages for AlSalam
    static var package1S = Packages(name: "Cardio-Metabolic Health Package", cost: "25", describtion: "Targets heart and metabolic health, checking cholesterol, blood sugar, and blood pressure.", insrtuctions: "For the Lipid Profile and Blood Glucose Level, fasting for 9-12 hours is typically required. No special preparation is needed for the Blood Pressure Check.", packageIncludes: [test1S,test2S,test3S], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 12, day: 31), facility: sampleFacilities[1])

        static var package2S = Packages(name: "General Wellness Package", cost: "30", describtion: "Provides a comprehensive health overview, assessing blood health, thyroid function, and Vitamin D levels.", insrtuctions: "No special preparation is needed for the Complete Blood Count (CBC) and Vitamin D Level tests. The Thyroid Function Test (TFT) is usually best conducted in the morning, but no fasting is required.", packageIncludes: [test4S,test5S,test6S], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 3, day: 31), facility: sampleFacilities[1])
    
    // Packages for Shifaa Aljazeera
    static var package1Shifa = Packages(name: "Active Lifestyle Package", cost: "60", describtion: "Designed for fitness enthusiasts, this package evaluates cardiovascular health, body composition, and bone density.", insrtuctions: "Wear athletic attire for the Aerobic Capacity Test. For the Body Composition Analysis and Bone Density Scan, wear minimal clothing and avoid metal accessories. Fasting may be required for the Bone Density Scan.", packageIncludes: [test1Shifa,test2Shifa,test3Shifa], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 12, day: 31), facility: sampleFacilities[2])

        static var package2Shifa = Packages(name: "Digestive Health Package", cost: "40", describtion: "Focuses on liver health, stomach bacteria, and gluten sensitivity, essential for digestive wellness.", insrtuctions: "Fasting may be necessary for the Liver Function test. Avoid certain medications for the H. Pylori test, and maintain a normal diet (including gluten) before the Gluten Sensitivity test.", packageIncludes: [test4Shifa, test5Shifa,test6Shifa], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 11, day: 30), facility: sampleFacilities[2])
    
    //Packages for King Hamad Hospital
    static var package1KHUH = Packages(name: "Cancer-Screening (Female Only)", cost: "150", describtion: "This package is designed for women to screen their body to detect cancer before any symptoms appear and increase their chance of winning against the cancer through early detection", insrtuctions: "(1)Avoid using lotions, perfumes, or powders before mammography. (2) Patients may be advised to schedule the test at a specific time during their menstrual cycle.", packageIncludes: [test4KHUH, test5KHUH,test6KHUH,test3KHUH,test7KHUH], packageExpiry: DateComponents(calendar: Calendar.current, year: 2023, month: 6, day: 30), facility: sampleFacilities[3])

        static var package2KHUH = Packages(name: "Women Wellness Screening", cost: "210", describtion: "This package is designed to seek guidelines about preventive measures and to review essentials of woman's reproductive health.", insrtuctions: "Avoid strenuous exercise and alcohol consumption 24 hours before the appointment.", packageIncludes: [test4KHUH, test8KHUH, test7KHUH], packageExpiry: DateComponents(calendar: Calendar.current, year: 2023, month: 6, day: 30), facility: sampleFacilities[3])
    
    
    //Packages for Bahrain Lab
    static var package1BHlab = Packages(name: "Kidney and Urinary Health Package", cost: "50", describtion: "This package is designed to assess urinary tract health and kidney function.", insrtuctions: "For the Bacterial Culture test, a midstream urine sample is required. Ensure proper collection techniques. For the PTU test, collect all urine over a 24-hour period in a provided container and store it in a cool place.", packageIncludes: [test2BHlab,test3BHlab], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 5, day: 16), facility: sampleFacilities[4])

        static var package2BHlab = Packages(name: "Liver Function and Metabolic Assessment", cost: "45", describtion: "Evaluates liver health and checks for conditions like gout or kidney stones.", insrtuctions: "For the Liver Profile, a blood sample is required with fasting for 8-12 hours. For the Uric Acid test, a body fluid sample (like joint fluid) is needed, with specific preparation depending on the fluid being collected.", packageIncludes: [test4BHlab,test5BHlab], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 2, day: 27), facility: sampleFacilities[4])
    
    //Packages for Thyrocare Gulf Laboratories
    static var package1Thy = Packages(name: "Basic Skills Assessment", cost: "50", describtion: "This package evaluates foundational skills in math, reading, and logical reasoning.", insrtuctions: "Complete a set of math problems, answer reading comprehension questions, and solve logical reasoning puzzles within specified time limits for each section.", packageIncludes: [test1Thy, test2Thy, test3Thy], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 17), facility: sampleFacilities[5])

    static var package2Thy = Packages(name: "Advanced Analytical Skills", cost: "48", describtion: "This package assesses advanced mathematical ability, critical reading, and abstract reasoning skills.", insrtuctions: "Tackle advanced math problems, critically analyze long-form essays, and solve abstract reasoning challenges, each within their respective time constraints.", packageIncludes: [test4Thy,test5Thy,test6Thy,test7Thy], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 11, day: 30), facility: sampleFacilities[5])
    
    //Packages for Alkindi Hospital
    static var package1Kindi = Packages(name: "Basic Health Check", cost: "125", describtion: "A fundamental package for overall health assessment, focusing on blood analysis, cholesterol levels, sugar levels, and blood pressure.", insrtuctions: "Fast for 8 hours before the test. Avoid strenuous exercise the day before.", packageIncludes: [test1Kindi,test2Kindi,test3Kindi,test4Kindi], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 6, day: 15), facility: sampleFacilities[6])

    static var package2Kindi = Packages(name: "Advanced Metabolic Profile", cost: "35", describtion: "Ideal for evaluating your body's metabolic functions, including liver, kidney health, thyroid function, and blood sugar levels.", insrtuctions: "Fast for 10-12 hours before the test. Avoid alcohol for 24 hours prior.", packageIncludes: [test3Kindi,test5Kindi,test6Kindi,test7Kindi], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 2, day: 2), facility: sampleFacilities[6])

    //Packaged for Alnafees Hospital
    static var package1Naf = Packages(name: "Diabetes Management Package", cost: "70", describtion: "Monitors blood sugar control over time and checks for diabetes-related complications.", insrtuctions: "No fasting required. For the CMP, fast for 8 hours prior.", packageIncludes: [test1Naf,test2Naf,test3Naf,test4Naf], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 3, day: 25), facility: sampleFacilities[7])

    static var package2Naf = Packages(name: "Men’s Health Package", cost: "110", describtion: "Focused on male-specific health concerns, including prostate health and vital vitamin levels.", insrtuctions: "No special preparations are needed. Fasting is not required.", packageIncludes: [test5Naf,test6Naf,test7Naf,test8Naf], packageExpiry: DateComponents(calendar: Calendar.current, year: 2025, month: 7, day: 14), facility: sampleFacilities[7])

    
    //Packages for Blossom Lab
    static var package1Blos = Packages(name: "Comprehensive Cardiac Risk Panel", cost: "90", describtion: "Assesses heart health by measuring markers of inflammation and metabolic function.", insrtuctions: "Fast for 8-12 hours prior to the test. Avoid strenuous exercise for 24 hours before the test.", packageIncludes: [test1Blos,test2Blos], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 5, day: 15), facility: sampleFacilities[8])

        static var package2Blos = Packages(name: "Bone Health Assessment", cost: "35", describtion: "Screens for bone density to assess the risk of osteoporosis and other bone-related conditions.", insrtuctions: "Wear loose clothing without metal fasteners. Avoid calcium supplements 24 hours before the test.", packageIncludes: [test3Blos,test4Blos], packageExpiry: DateComponents(calendar: Calendar.current, year: 2025, month: 3, day: 20), facility: sampleFacilities[8])
    
    //Packages for Aster Hospital
    static var package1Ast = Packages(name: "Aster Fitness Package", cost: "40", describtion: "Comprehensive health check-up including Iron Deficiency, Lipid Profile, Vitamin D, and Complete Blood Count tests.", insrtuctions: "Fast for 8-12 hours before your test. Stay hydrated with water. Avoid strenuous exercise and alcohol 24 hours prior.", packageIncludes: [test1Ast,test2Ast,test3Ast,test4Ast], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 3, day: 20), facility: sampleFacilities[9])

    static var package2Ast = Packages(name: "Aster Hair Loss Package", cost: "29", describtion: "Targeted hair health package with Thyroid Function Test, Ferritin, Zinc, and Complete Blood Count.", insrtuctions: "Maintain your normal diet but avoid supplements containing biotin for 48 hours before testing. Stay hydrated.", packageIncludes: [test1Ast,test5Ast,test6Ast,test7Ast], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 20), facility: sampleFacilities[9])
    
    //Packages for Alresalah Hospital
    static var package1Res = Packages(name: "Golden Package", cost: "40", describtion: "Comprehensive health assessment including Kidney Profile, Liver Profile, Lipids Profile, and Thyroid Function Test (TFT).", insrtuctions: "Fast for 8-12 hours before your tests. Avoid alcohol and strenuous exercise for 24 hours prior. Stay hydrated with water only.", packageIncludes: [test1Res,test2Res,test7Res,test8Res], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 3, day: 12), facility: sampleFacilities[10])

    static var package2Res = Packages(name: "Hair Loss Package", cost: "20", describtion: "Specialized package for hair health with Ferritin, Vitamin D, CBC (Complete Blood Count), and Zinc tests.", insrtuctions: "Avoid biotin supplements for 48 hours before testing. No fasting required, but stay hydrated.", packageIncludes: [test3Res,test4Res,test6Res], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 5, day: 20), facility: sampleFacilities[10])
    
    //Packages for Alrayan Hospital
    static var package1Ray = Packages(name: "Vitamins & Minerals Package", cost: "40", describtion: "Comprehensive assessment of key vitamins and minerals, including Vitamin D, Calcium, Iron, and Vitamin B12, crucial for overall health.", insrtuctions: "Vitamin D and Vitamin B12 tests usually don't require any special preparation. For Calcium and Iron tests, fasting for 8-12 hours may be recommended.", packageIncludes: [test1Ray,test2Ray,test3Ray,test4Ray], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 9, day: 25), facility: sampleFacilities[11])

    static var package2Ray = Packages(name: "Hair Loss Package", cost: "19", describtion: "Targets common nutritional deficiencies and hormonal imbalances related to hair loss.", insrtuctions: "Vitamin D and Zinc tests typically require no fasting. Iron (Ferritin) and Thyroid Function (TSH) tests may require fasting for accurate results.", packageIncludes: [test5Ray,test6Ray,test7Ray,test8Ray], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 8, day: 1), facility: sampleFacilities[11])
    
    //Packages for Bahrain Specialst Lab
    static var package1bhSp = Packages(name: "Vital Wellness Package", cost: "50", describtion: "A fundamental package for assessing vital health parameters and thyroid function.", insrtuctions: "Fast for 8-10 hours before the test. Avoid taking thyroid and steroid medications before the test.", packageIncludes: [test1bhSp,test2bhSp,test3bhSp], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 5, day: 5), facility: sampleFacilities[12])

    static var package2bhSp = Packages(name: "Metabolic Insight Package", cost: "23", describtion: "Comprehensive screening focusing on metabolic functions and liver health.", insrtuctions: "Fast for 12 hours prior to the test. Avoid alcohol for 24 hours before testing.", packageIncludes: [test4bhSp,test5bhSp,test6bhSp], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 10, day: 10), facility: sampleFacilities[12])

    //Packages for Express Med
    static var package1Exp = Packages(name: "Essential Wellness Package", cost: "40", describtion: "A fundamental health assessment focusing on blood health, glucose levels, and liver wellness.", insrtuctions: "Fast for 8-12 hours before the test.", packageIncludes: [test1Exp,test2Exp,test3Exp], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 4, day: 13), facility: sampleFacilities[13])

    static var package2Exp = Packages(name: "Thyroid and Nutrition Profile", cost: "30", describtion: "Evaluates thyroid health and essential vitamin levels for overall wellness.", insrtuctions: "Fast for 8-10 hours before the Thyroid Function Test. No fasting required for Vitamin D and B12 tests.", packageIncludes: [test4Exp,test5Exp,test6Exp], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 4, day: 4), facility: sampleFacilities[13])
    
    //Packages for AlAmal Hospital
    static var package1Amal = Packages(name: "Balanced Health Check", cost: "40", describtion: "A general health assessment covering blood health, liver function, and vitamin levels.", insrtuctions: "Fast for 8-12 hours for the liver function test. No fasting required for CBC and Vitamin B12 Test.", packageIncludes: [test1Amal,test2Amal,test3Amal], packageExpiry: DateComponents(calendar: Calendar.current, year: 2025, month: 3, day: 13), facility: sampleFacilities[14])

    static var package2Amal = Packages(name: "Cardio Wellness Profile", cost: "30", describtion: "Focuses on cardiovascular and glucose level assessment.", insrtuctions: "Fast for 12 hours prior to both tests.", packageIncludes: [test4Amal,test5Amal], packageExpiry: DateComponents(calendar: Calendar.current, year: 2024, month: 6, day: 2), facility: sampleFacilities[14])





    
    static var packages: [Packages] = [package1H, package2H, package1S, package2S, package1Shifa,package2Shifa,package1BHlab,package2BHlab,package1Blos,package2Blos,package1KHUH,package2KHUH,package1Thy,package2Thy,package1Kindi,package2Kindi,package1Naf,package2Naf,package1Ast,package2Ast,package1Res,package2Res,package1Ray,package2Ray,package1bhSp,package2bhSp,package1Exp,package2Exp,package1Amal,package2Amal]

    // Combined array of all tests and packages.
    static var allTestsPackages: [Service] = [test1H,test2H, test3H,test4H,test5H, test6H,test7H, test8H,test1S, test2S, test3S, test4S, test5S,test6S,test1Shifa, test2Shifa, test3Shifa, test4Shifa,test5Shifa,test6Shifa,test1BHlab,test2BHlab,test3BHlab,test4BHlab,test5BHlab,test1Blos,test2Blos,test3Blos,test4Blos,test5Blos,test6Blos,test1KHUH,test2KHUH,test3KHUH,test4KHUH,test5KHUH,test6KHUH, test7KHUH,test8KHUH,test9KHUH,test10KHUH,test1Thy,test2Thy,test3Thy,test4Thy,test5Thy,test6Thy,test7Thy,test1Kindi,test2Kindi,test3Kindi,test4Kindi,test5Kindi,test6Kindi,test7Kindi,test1Naf,test2Naf,test3Naf,test4Naf,test5Naf,test6Naf,test7Naf,test8Naf,test9Naf,test1Ast,test2Ast,test3Ast,test4Ast,test5Ast,test6Ast,test7Ast,test8Ast,test9Ast,test1Res,test2Res,test3Res,test4Res,test5Res,test6Res,test7Res,test8Res,test1Ray,test2Ray,test3Ray,test4Ray,test5Ray,test6Ray,test7Ray,test8Ray,test9Ray,test1bhSp,test2bhSp,test3bhSp,test4bhSp,test5bhSp,test6bhSp,test7bhSp,test1Exp,test2Exp,test3Exp,test4Exp,test5Exp,test6Exp,test7Exp,test1Amal,test2Amal,test3Amal,test4Amal,test5Amal,test6Amal,test7Amal,package1H, package2H,package1S, package2S, package1Shifa,package2Shifa,package1BHlab,package2BHlab,package1Blos,package2Blos,package1KHUH,package2KHUH,package1Thy,package2Thy,package1Kindi,package2Kindi, package1Naf,package2Naf,package1Ast,package2Ast,package1Res,package2Res,package1Ray,package2Ray,package1bhSp,package2bhSp,package1Exp,package2Exp,package1Amal,package2Amal]
    
    
    //bookings Dummy Data
    static var sampleBookings = [
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2023, month: 12, day:22), patient: samplePatients[3], medicalService: tests[1]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2023, month: 12, day:22), patient: samplePatients[4], medicalService: tests[0]),
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2023, month: 12, day:23), patient: samplePatients[2], medicalService: tests[2]),
            booking(booking_date: DateComponents(calendar: Calendar.current, year: 2023, month: 12, day:24), patient: samplePatients[1], medicalService: tests[3]),
            booking(booking_date: DateComponents(calendar: Calendar.current, year: 2023, month: 12, day:25), patient: samplePatients[0], medicalService: tests[4]),
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2023, month: 12, day: 26), patient: samplePatients[0], medicalService: packages[0]),
        
           booking(booking_date: DateComponents(calendar: Calendar.current, year: 2023, month: 12, day: 27), patient: samplePatients[1], medicalService: packages[1]),
        
           booking(booking_date: DateComponents(calendar: Calendar.current, year: 2023, month: 12, day: 28), patient: samplePatients[2], medicalService: packages[2]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 5), patient: samplePatients[0], medicalService: tests[0]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 6), patient: samplePatients[1], medicalService: tests[1]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 7), patient: samplePatients[2], medicalService: tests[2]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 8), patient: samplePatients[3], medicalService: tests[3]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 9), patient: samplePatients[4], medicalService: tests[4]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 10), patient: samplePatients[5], medicalService: packages[0]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 11), patient: samplePatients[6], medicalService: packages[1]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 12), patient: samplePatients[7], medicalService: packages[2]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 13), patient: samplePatients[8], medicalService: packages[3]),
        
        booking(booking_date: DateComponents(calendar: Calendar.current, year: 2024, month: 1, day: 14), patient: samplePatients[9], medicalService: packages[4])

            
        ]
    
}
