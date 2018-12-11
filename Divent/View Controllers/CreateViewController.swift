//
//  CreateViewController.swift
//  Divent
//
//  Created by Michael Weir on 11/23/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit

class CreateViewController: DiventViewController, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    

    
    fileprivate var ref : DatabaseReference? // Firebase variable

    @IBOutlet weak var datePickerTF: UITextField!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var activityPickerTF: UITextField!
    let activityPicker = UIPickerView()
    
  
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var moreDetails: UITextView!
    
    @IBOutlet weak var activityTitle: UITextField!
    
    @IBOutlet weak var locationTF: UITextField!
 
    
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
    
    @IBAction func locationClicked(_ sender: Any) {
        
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
        locationTF.text = ""
    }
    
    func toDictionary(vals: dataArray)->NSDictionary{
        return[
        
            "activityPickerTF": NSString(string: vals.activityPickerTF),
            "activityTitle": NSString(string: vals.activityTitle),
            "locationTF": NSString(string: vals.locationTF),
            "datePickerTF": NSString(string: vals.datePickerTF),
            "moreDetails": NSString(string: vals.moreDetails)
    ]
        
    }
    
    

    @IBAction func confirmClicked(_ sender: Any) {
       
        let dialogMessage = UIAlertController(title: "Confirm", message: "Create this activity?", preferredStyle: .alert)
        
       
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.confirmRecord()
        })
        
 
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
       
        self.present(dialogMessage, animated: true, completion: nil)
    }

    func confirmRecord()
    {

        print("Activity being confirmed")
      
        if(datePickerTF.hasText && activityTitle.hasText && moreDetails.hasText && activityPickerTF.text == "Sports" || activityPickerTF.text == "Gaming"
            || activityPickerTF.text == "Hangout" || activityPickerTF.text == "Nightlife" || activityPickerTF.text == "Other"){
            
            let dialogMessage = UIAlertController(title: "Activity Confirmed", message: "Your activity has been added", preferredStyle: .alert)

         
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })

            dialogMessage.addAction(ok)
            let entry = dataArray(activityPickerTF: activityPickerTF.text!, activityTitle: activityTitle.text!, locationTF: locationTF.text!, datePickerTF: datePickerTF.text!, moreDetails: moreDetails.text!)
            let newChild = self.ref?.child("activity").childByAutoId()
            newChild?.setValue(self.toDictionary(vals:entry))
            self.present(dialogMessage, animated: true, completion: nil)
            resetValues()
        }
         
        else{
            let dialogMessage = UIAlertController(title: "Activity Denied", message: "Please check that all forms are filled correctly", preferredStyle: .alert)
            
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
            
        }

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreDetails.isScrollEnabled = false
        self.ref = Database.database().reference()
        self.registerForFireBaseUpdates()
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
                
                var tmpItems = [dataArray]()
                for (_,val) in postDict.enumerated() {
                    let entry = val.1 as! Dictionary<String,AnyObject>
                    let activityPickerTF = entry["activityPickerTF"] as! String?
                    let activityTitle = entry["activityTitle"] as! String?
                    let locationTF = entry["locationTF"] as! String?
                    let datePickerTF = entry["datePickerTF"] as! String?
                    let moreDetails = entry["moreDetails"] as! String?
                    
                    
                    tmpItems.append(dataArray(activityPickerTF: activityPickerTF!, activityTitle: activityTitle!, locationTF: locationTF!, datePickerTF: datePickerTF!, moreDetails: moreDetails!))
 
                }
            }
        })
        
    }



    
}
