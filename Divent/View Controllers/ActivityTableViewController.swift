//
//  ActivityTableViewController.swift
//  Divent
//
//  Created by Michael Weir on 12/8/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit
import Firebase


class HeadlineViewCell: UITableViewCell{

    
     var entries : [dataArray] = []
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var label2: UILabel!
    
    
    
    @IBOutlet weak var label3: UILabel!
    
    
    @IBOutlet weak var label4: UILabel!
    
    
    @IBOutlet weak var label5: UILabel!
    
    
    
    
}

class ActivityTableViewController: UITableViewController{
    
    
    let activityData = Database.database().reference().child("activities")
    var entries : [dataArray] = []
 //   let Activites = "Activities"
    var ref:DatabaseReference!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! HeadlineViewCell


        
        let test = entries[indexPath.row]
        cell.label1?.text = test.activityPickerTF
        cell.label2?.text = test.activityTitle
        cell.label3?.text = test.locationTF
        cell.label4?.text = test.datePickerTF
        cell.label5?.text = test.moreDetails

        print("cell data")
        print(test.activityPickerTF)
        print(cell.label1?.text)
        print(cell.label2?.text)
        print(cell.label3?.text)
        print(cell.label4?.text)
        print(cell.label4?.text)
        print(test.activityPickerTF)
        print(test.activityTitle)
        print(test.locationTF)
        print(test.datePickerTF)
        print(test.moreDetails)

        print(cell)
        
        return cell

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//   self.tableView.register(HeadlineViewCell.classForKeyedArchiver(), forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    


 
        LoadCalls()
    //    self.tableView.reloadData()
    }
    
    func LoadCalls() {

        ref = Database.database().reference()

        ref.child("activity").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            print(snapshot)
       
            if snapshot.childrenCount > 0 {
            let results = snapshot.value as? [String : AnyObject]
            let activity = results?["activityPickerTF"]
            let activityTitleText = results?["activityTitle"]
            let locationText = results?["locationTF"]
            let datePickerText = results?["datePickerTF"]
            let moreDetailsText = results?["moreDetails"]
//                print(activity)
//                print(activityTitleText)
//                print(locationText)
//                print(datePickerText)
//                print(moreDetailsText)

                
            let myCalls = dataArray(activityPickerTF: (activity as! String?)!, activityTitle: (activityTitleText as! String?)!, locationTF: (locationText as! String?)!, datePickerTF: (datePickerText as! String?)!, moreDetails: (moreDetailsText as! String?)!)
                
         //       print(myCalls)
                
            self.entries.append(myCalls)
            self.tableView.reloadData()
            
            
            }
        })
    }
    
}

