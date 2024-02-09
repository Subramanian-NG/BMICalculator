//
//  BMICalculator.swift
//  BMICalculator
//
//  Created by user238111 on 2/8/24.
//

import Foundation



class BMICalculator
{
    func calculateBMI(height1:Double, height2:Double, weight: Double, mesureType: String) -> Double
    {
        var bmiValue: Double = 0.0
        if mesureType == "STANDARD"
        {
            let heightInMeters = (height1 * 12 + height2)*0.0254
                
            let weightInKilograms = weight * 0.453592
                
            bmiValue = weightInKilograms / (heightInMeters * heightInMeters)
        }
        else
        {
            let heightInMeters = height1 / 100.0
                
            bmiValue = weight / (heightInMeters * heightInMeters)
        }
        
        return bmiValue
    }
    
    func findCategory(bmiValue:Double) -> String
    {
        if bmiValue < 18.5
        {
            return "Underweight"
        }
        else if(bmiValue >= 18.5 && bmiValue < 25)
        {
            return "Normal"
        }
        else
        {
            return "Overweight"
        }
        
    }
}
