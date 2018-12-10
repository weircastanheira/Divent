//
//  ViewController.swift
//  Divent
//
//  Created by Michael Weir on 11/23/18.
//  Copyright © 2018 Michael Weir & Filipe Castanheira. All rights reserved.
//

import UIKit
import FacebookShare
import Firebase

class ViewController: UIViewController {
    
    @IBAction func shareClicked(_ sender: Any) {
        let content:LinkShareContent = LinkShareContent.init(url: URL.init(string: "https://www.google.com") ?? URL.init(fileURLWithPath: "https://www.google.com"), quote: "I'm using the Divent App! You should too!")
        
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .native
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            // Handle share results
        }
        do
        {
            try shareDialog.show()
        }
        catch
        {
            print("Exception")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("Data", parameters: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

