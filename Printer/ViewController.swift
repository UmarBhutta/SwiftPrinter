//
//  ViewController.swift
//  Printer
//
//  Created by Malik Umar Bhutta on 7/14/16.
//  Copyright © 2016 Malik Umar Bhutta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var printerName: UITextView!
    @IBOutlet weak var printButton: UIButton!

    @IBAction func OnPrintClick(sender: AnyObject) {
        
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = UIPrintInfoOutputType.General
        printInfo.jobName = "My Print Job"
        printInfo.orientation = .Portrait
 
        let printController = UIPrintInteractionController.sharedPrintController()
        printController.printInfo = printInfo
        
        let myPrinter = UIPrinter(URL: userDefaults.URLForKey("printer")!)
        printController.printingItem = printerName.text! + "My Printer Works"
        
        printController.printToPrinter(myPrinter, completionHandler: nil)
        
    }
    
   
    
    let userDefaults =  NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let isPrinterAdded = userDefaults.boolForKey("printerAdded")
        if(isPrinterAdded){
            printerName.text = userDefaults.URLForKey("printer")?.absoluteString
            printButton.enabled = true
        }else{
            printerName.text = "No Printer Added"
            printButton.enabled = false
            OpenPrinterPicker()
        }
        
        
        
    }
    
    func OpenPrinterPicker() {
        let pickerController = UIPrinterPickerController(initiallySelectedPrinter: nil)
        pickerController.presentAnimated(true) { (controller:UIPrinterPickerController!, completed:Bool, error:NSError?) -> Void in
            self.userDefaults.setURL(controller.selectedPrinter?.URL, forKey: "printer")
            self.userDefaults.setBool(true, forKey: "printerAdded")
            self.printButton.enabled = true
            self.printerName.text = controller.selectedPrinter?.URL.absoluteString
           
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

