//
//  ViewController.swift
//  Prog2-Bead0044Sum21
//
//  Created by Elizabeth Dayton on 6/17/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var loanAmountController: UITextField!
    
    @IBOutlet weak var numPayPeriodsController: UITextField!
    
    @IBOutlet weak var interestRatePerPayPeriod: UITextField!
    
    @IBOutlet weak var resultController: UILabel!
    
    @IBAction func TapGestureRecognized(_ sender: Any) {
        loanAmountController.resignFirstResponder()
        numPayPeriodsController.resignFirstResponder()
        interestRatePerPayPeriod.resignFirstResponder()
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        
        if let loanAmount: Float = Float(loanAmountController.text!),
           let numberOfPaymentPeriods = Int(numPayPeriodsController.text!),
           let interestRatePerPaymentPeriod = Float(interestRatePerPayPeriod.text!) {
            
            let numerator: Float = (loanAmount * interestRatePerPaymentPeriod)
            let denominator: Float = ((1.0) - pow((1.0 + interestRatePerPaymentPeriod), -Float(numberOfPaymentPeriods)))
            
            let paymentPerPeriod = numerator/denominator
            
            resultController.text = "Payment Amount is \(paymentPerPeriod)"
            
        }
        
        
        else {
            resultController.text = "One or more fields are invalid"
        }
        
    }
}

