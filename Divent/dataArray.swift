//
//  dataArray.swift
//  
//
//  Created by Michael Weir on 12/8/18.
//

import Foundation

struct dataArray{
    var activityPickerTF: String
    var activityTitle: String
    var locationTF: String
    var datePickerTF: String
    var moreDetails: String
    
    init(activityPickerTF: String, activityTitle: String, locationTF: String,
         datePickerTF: String, moreDetails: String){
        self.activityPickerTF = activityPickerTF
        self.activityTitle = activityTitle
        self.locationTF = locationTF
        self.datePickerTF = datePickerTF
        self.moreDetails = moreDetails
    }
}
