//
//  SearchViewController.swift
//  Divent
//
//  Created by Michael Weir on 11/23/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SearchViewController:DiventViewController,UIPickerViewDataSource,UIPickerViewDelegate  {

    
    @IBOutlet weak var mileSliderValue: UILabel!
    

    
    @IBOutlet weak var activityPickerTF: UITextField!
    let activityPicker = UIPickerView()
    
    var locationManager: CLLocationManager!
    var selection: String = "Any"
    var mileValue: String?
    var activityTypeValue: String?

    
    
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
        activityPickerTF.text = pickerData[row]
    }

    @IBAction func backClicked(_ sender: Any) {
        //none
        
    }
    
    
    @IBAction func beginSearchClicked(_ sender: Any) {
        self.activityTypeValue = activityPickerTF.text
        performSegue(withIdentifier: "search", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as? ActivityTableViewController
        vc?.activityTypeData = self.activityTypeValue!
    }
    func createActivityPicker(){
        activityPickerTF.inputView = activityPicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneActivityClicked))
        toolbar.setItems([doneButton], animated: true)
        activityPickerTF.inputAccessoryView = toolbar
    }
    @objc func doneActivityClicked(){
        self.view.endEditing(true)
    }
    
    @objc func hidePickers(){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.keyWindow?.windowLevel = UIWindow.Level.normal
        activityPicker.delegate = self
        createActivityPicker()
        
    let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.self.hidePickers))
        
        self.view.addGestureRecognizer(detectTouch)

    }
}


