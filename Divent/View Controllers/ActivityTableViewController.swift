//
//  ActivityTableViewController.swift
//  Divent
//
//  Created by Michael Weir on 12/8/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit



class HeadlineViewCell: UITableViewCell{

    @IBAction func lookupClicked(_ sender: Any) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(label3.text!) { (placemarks, error) in
            
            if error != nil {
            } else if let placemarks = placemarks {
                
                if (placemarks.first?.location?.coordinate) != nil {
                 //   print(placemarks.first?.location?.coordinate)
 
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: (placemarks.first?.location?.coordinate)!, addressDictionary:nil))
                    mapItem.name = self.label3.text
                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                }
            }
        }

    }
    
    
     var entries : [dataArray] = []
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var label2: UILabel!
    
    
    
    @IBOutlet weak var label3: UILabel!
    
    
    @IBOutlet weak var label4: UILabel!
    
    
    @IBOutlet weak var label5: UILabel!
    
    
}

class ActivityTableViewController: UITableViewController{
    
    var activityTypeData = ""
    
    let activityData = Database.database().reference().child("activities")
    var entries : [dataArray] = []
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
        cell.contentView.backgroundColor = BACKGROUND_COLOR

        
        if(test.activityPickerTF == activityTypeData || activityTypeData == "Any"){
            //do nothing
        }
        else{
            //remove cell from view
            entries.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        return cell

    }

    
    @IBAction func backClicked(_ sender: Any) {
        //nothing
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.keyWindow?.windowLevel = UIWindow.Level.statusBar
        self.tableView.backgroundColor = BACKGROUND_COLOR
        self.tableView.allowsSelection = false
        

        self.tableView.delegate = self
        self.tableView.dataSource = self
    
 
        LoadCalls()

    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
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


                
            let myCalls = dataArray(activityPickerTF: (activity as! String?)!, activityTitle: (activityTitleText as! String?)!, locationTF: (locationText as! String?)!, datePickerTF: (datePickerText as! String?)!, moreDetails: (moreDetailsText as! String?)!)

                
            self.entries.append(myCalls)
            self.tableView.reloadData()
            
            
            }
        })
    }
    
}

