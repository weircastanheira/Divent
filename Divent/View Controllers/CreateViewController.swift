//
//  CreateViewController.swift
//  Divent
//
//  Created by Michael Weir on 11/23/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit
import Firebase

class CreateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    fileprivate var ref : DatabaseReference? // Firebase variable
    @IBOutlet weak var pickerView: UIPickerView!
    
    let pickerData = ["Any","Sports","Gaming","Hangout","Nightlife","Other"]
    
    
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Firebase implementation
        self.ref = Database.database().reference()
        self.registerForFireBaseUpdates()
    }
    
//    Necessary for Firebase process
    fileprivate func registerForFireBaseUpdates()
    {
        self.ref!.child("history").observe(.value, with: { snapshot in
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
