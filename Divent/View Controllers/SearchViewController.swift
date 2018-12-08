//
//  SearchViewController.swift
//  Divent
//
//  Created by Michael Weir on 11/23/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit

protocol searchDelegation{
    func settingsChanged(activityText: String, mileSliderValue: String)
}

class SearchViewController:UIViewController,UIPickerViewDataSource,UIPickerViewDelegate  {

    
    @IBOutlet weak var mileSliderValue: UILabel!
    

    
    @IBOutlet weak var activityPickerTF: UITextField!
    let activityPicker = UIPickerView()
    
    
    var delegate: SearchViewController?
    var selection: String = "Any"
    
    @IBAction func mileSlider(_ sender: UISlider) {
        mileSliderValue.text = String(Int(sender.value))
    }
    
    
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


    
    
    
    @IBAction func beginSearchClicked(_ sender: Any) {
//        delegate?.settingsChanged(activityText: activityText!.text!, mileSliderValue: mileSliderValue!.text!)
//
//        _ = self.navigationController?.popViewController(animated: true)
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
        activityPicker.delegate = self
        createActivityPicker()
        
    let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.self.hidePickers))
        
        self.view.addGestureRecognizer(detectTouch)

        // Do any additional setup after loading the view.
    }
    
    



}


