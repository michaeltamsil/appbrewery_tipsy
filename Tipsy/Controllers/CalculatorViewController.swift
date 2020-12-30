//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UIStackView!
    @IBOutlet weak var splitNumber: UILabel!
    
    var tip = 0.1
    var numberOfPeople = 2
    var perPersonBill = 0.0

    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false

        sender.isSelected = true
        let buttonTitle = sender.currentTitle
        
        let buttonTitleMinusPercentSign = String((buttonTitle?.dropLast())!)
        
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)
        
        tip = buttonTitleAsNumber! / 100
        
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumber.text =  String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = Double(String(billTextField.text ?? "0.0"))
        if bill != nil {
            self.perPersonBill = Double(bill! + (bill!  * tip)) / Double(numberOfPeople)
            self.performSegue(withIdentifier: "calculateSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "calculateSegue" {
            let resultViewController = segue.destination as! ResultsViewController
            resultViewController.total = self.perPersonBill
            resultViewController.settings = "split between \(numberOfPeople) people, with \(tip * 100 )% tip."
        }
    }
}

