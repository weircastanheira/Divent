//
//  CreateViewController.swift
//  Divent
//
//  Created by Michael Weir on 11/23/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit
import Firebase

class CreateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    fileprivate var ref : DatabaseReference? // Firebase variable

    
    @IBOutlet weak var datePickerTF: UITextField!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var activityPickerTF: UITextField!
    let activityPicker = UIPickerView()
    
  
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var moreDetails: UITextView!
    
    @IBOutlet weak var activityTitle: UITextField!
    
    let pickerData = ["Choose...","Sports","Gaming","Hangout","Nightlife","Other"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String?{
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        activityPickerTF.text = pickerData[row]
    }
    
    func createActivityPicker(){
        activityPickerTF.inputView = activityPicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneActivityClicked))
        toolbar.setItems([doneButton], animated: true)
        activityPickerTF.inputAccessoryView = toolbar
        
    }
    
    func createDatePicker(){
        let thisYear = Calendar.current.component(.year, from: Date())
        let todaysDate = Date()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = todaysDate
        datePicker.maximumDate = Calendar.current.date(from:DateComponents(year: thisYear+2))
        datePickerTF.inputView = datePicker
       
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDateClicked))
        
        toolbar.setItems([doneButton], animated: true)
        datePickerTF.inputAccessoryView = toolbar
    }
    
    @objc func doneDateClicked(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        datePickerTF.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func doneActivityClicked(){
        self.view.endEditing(true)
    }
    
    @objc func hidePickers(){
        self.view.endEditing(true)
    }
    @objc func resetValues(){
        activityPickerTF.text = "Choose..."
        datePickerTF.text = ""
        moreDetails.text = "Details here (time, etc...)"
        activityTitle.text = ""
    }
    
    

    @IBAction func confirmClicked(_ sender: Any) {
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirm", message: "Create this activity?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.confirmRecord() //firebase here?
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func confirmRecord()
    {
        //if statement if every label is correct types etc / filled out
        print("Activity being confirmed")
        //change below to if critera met
        if(datePickerTF.hasText && activityTitle.hasText && moreDetails.hasText &&             activityPickerTF.text == "Sports" || activityPickerTF.text == "Gaming"
            || activityPickerTF.text == "Hangout" || activityPickerTF.text == "Nightlife" || activityPickerTF.text == "Other"){
            
            let dialogMessage = UIAlertController(title: "Activity Confirmed", message: "Your activity has been added", preferredStyle: .alert)

            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })

            dialogMessage.addAction(ok)

            self.present(dialogMessage, animated: true, completion: nil)
            resetValues()
        }
            //if critera is unmet
        else{
            let dialogMessage = UIAlertController(title: "Activity Denied", message: "Please check that all forms are filled correctly", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
            
        }
        
        // possibly change this to the firebase function
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityPicker.delegate = self
        createDatePicker()
        createActivityPicker()
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.self.hidePickers))
        self.view.addGestureRecognizer(detectTouch)
        
//        Firebase implementation
        self.ref = Database.database().reference()
        self.registerForFireBaseUpdates()
    }
    
//    Necessary for Firebase process
    fileprivate func registerForFireBaseUpdates()
    {
        self.ref!.child("activities").observe(.value, with: { snapshot in
            if let postDict = snapshot.value as? [String : AnyObject] {
                //                TODO: Change this to actual project's values
                /*
                var tmpItems = [Conversion]()
                for (_,val) in postDict.enumerated() {
                    let entry = val.1 as! Dictionary<String,AnyObject>
                    let timestamp = entry["timestamp"] as! String?
                    let origFromVal = entry["origFromVal"] as! Double?
                    let origToVal = entry["origToVal"] as! Double?
                    let origFromUnits = entry["origFromUnits"] as! String?
                    let origToUnits = entry["origToUnits"] as! String?
                    let origMode = entry["origMode"] as! String?
                    
                    tmpItems.append(Conversion(fromVal: origFromVal!, toVal: origToVal!, mode: CalculatorMode(rawValue: origMode!)!, fromUnits: origFromUnits!, toUnits: origToUnits!, timestamp: (timestamp?.dateFromISO8601)!))
                }
                */
//                self.entries = tmpItems
            }
        })
        
    }

    
}
