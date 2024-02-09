//
//  ViewController.swift
//  BMICalculator
//
//  Created by user238111 on 2/2/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var measureType: UISegmentedControl!
    
    @IBOutlet weak var heightType1: UITextField!
   
    @IBOutlet weak var heightType2: UITextField!
    
    @IBOutlet weak var weightType: UITextField!
    
    @IBOutlet weak var bmiValue: UITextField!
    
    @IBOutlet weak var bmiCategories: UITextView!
    
    @IBOutlet weak var resultCategory: UILabel!
    
    @IBOutlet weak var heightValidationMsg: UILabel!
    
    @IBOutlet weak var weightValidationMsg: UILabel!
    
    var selectedMeasureType = "STANDARD"
    
    @IBAction func onChangeMeasureType(_ sender: Any) {
        
        let uiSelectedMeasureType = sender as! UISegmentedControl
        let selectedSegmentIndex = uiSelectedMeasureType.selectedSegmentIndex
        if selectedSegmentIndex != UISegmentedControl.noSegment {
            if let goodMeasureType = uiSelectedMeasureType.titleForSegment(at: selectedSegmentIndex) {
                if goodMeasureType == "STANDARD" {
                    heightType2.isHidden = false
                    heightType1.placeholder = "ft"
                    heightType2.placeholder = "in"
                    weightType.placeholder = "lb"
                    selectedMeasureType = "STANDARD"
                }
                if goodMeasureType == "METRIC"{
                    heightType2.isHidden = true
                    heightType1.placeholder = "cm"
                    weightType.placeholder = "kg"
                    selectedMeasureType = "METRIC"
                }
            }
        }


    }
    
    @IBAction func calculateBMI(_ sender: Any) {
        
        var validationStatus : Bool	= checkForEmptyAndNegativeValue(input: heightType1, fieldName: "Height",validationMsgLabel: heightValidationMsg)
        
        if !validationStatus
        {
            return
        }
            
        validationStatus  =  checkForEmptyAndNegativeValue(input: weightType, fieldName: "Weight", validationMsgLabel: weightValidationMsg)
        
        if !validationStatus
        {
            return
        }
        
        if selectedMeasureType == "STANDARD"
        {
            if let isInchFieldEmpty = heightType2.text?.isEmpty
            {
                if !isInchFieldEmpty
                {
                    var doubleString : Double? = Double(heightType2.text!)
                    if let goodDoubleString = doubleString
                    {
                        if goodDoubleString < 0
                        {
                            heightValidationMsg.text = "Inch value cannot be negative"
                            return
                        }
                    }
                    else
                    {
                        heightValidationMsg.text = "Inch value should be numerical"
                        return
                    }
                }
            }
        }
        
        var calculatedBmiValue : Double = 0.0
        if (selectedMeasureType == "STANDARD")
        {
            if let height1 = Double(heightType1.text ?? ""),
               let weight = Double(weightType.text ??     ""), let height2 = Double(heightType2.text ??     "")
            {
                calculatedBmiValue = BMICalculator().calculateBMI(height1: height1, height2: height2, weight: weight, mesureType: selectedMeasureType)
            }
            else {
                print("Invalid input for height or weight.")
            }
        }
        else
        {
            if let height1 = Double(heightType1.text ?? ""),
               let weight = Double(weightType.text ?? 	"")
            {
                
                calculatedBmiValue = BMICalculator().calculateBMI(height1: height1, height2: 0.0, weight: weight, mesureType: selectedMeasureType)
            }
            else {
                print("Invalid input for height or weight.")
            }
        }
            
        let category = BMICalculator().findCategory(bmiValue: calculatedBmiValue)
        bmiValue.text = String(calculatedBmiValue)
            
        bmiCategories.isHidden = false
        resultCategory.text = category
    }
    @IBAction func clearValues(_ sender: Any) {
        heightType1.text = ""
        heightType2.text = ""
        weightType.text = ""
        bmiCategories.isHidden = true
        resultCategory.text = ""
        heightValidationMsg.text = ""
        weightValidationMsg.text = ""
        bmiValue.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiValue.isUserInteractionEnabled = false
        bmiCategories.isHidden = true
       
    }
    
    func checkForEmptyAndNegativeValue(input: Any, fieldName: String, validationMsgLabel: Any)-> Bool
    {
        let inputField = input as! UITextField
        let validationMsg = validationMsgLabel as! UILabel
        
        if let goodBoolean = inputField.text?.isEmpty
        {
            if goodBoolean
            {
                validationMsg.text = "\(fieldName) value cannot be empty"
                return false
            }
            
            else
            {
                var doubleString : Double? = Double(inputField.text!)
                if let goodDoubleString = doubleString
                {
                    if goodDoubleString < 0
                    {
                        validationMsg.text = "\(fieldName) value cannot be negative"
                        return false
                    }
                }
                else
                {
                    validationMsg.text = "\(fieldName) value should be numerical"
                    return false
                }
            }
        }
        return true
    }

}

