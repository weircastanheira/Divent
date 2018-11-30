//
//  SearchViewController.swift
//  Divent
//
//  Created by Michael Weir on 11/23/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit

class SearchViewController:UIViewController,UIPickerViewDataSource,UIPickerViewDelegate  {

    
    @IBOutlet weak var mileSliderValue: UILabel!
    

    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var activityText: UILabel!
    
    @IBOutlet weak var setButton: UIButton!
    
    @IBAction func changeButton(_ sender: UIButton) {
        pickerView.isHidden = false
        setButton.isHidden = false
    }
    
    
    @IBAction func setClicked(_ sender: UIButton) {
        pickerView.isHidden = true
        setButton.isHidden = true
    }
    
    
    
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
          activityText.text = pickerData[row]
        }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        

        // Do any additional setup after loading the view.
    }
    
    



}


