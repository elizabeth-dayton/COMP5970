import UIKit

func payment(loanAmount: Int, numOfPayments: Int, interestRate: Float)->Float {
 
    let numerator: Float = (Float(loanAmount) * interestRate)
    let denominator: Float = ((1.0) - pow((1.0 + interestRate), -Float(numOfPayments)))
    
    let paymentPerPeriod = numerator/denominator
    
    return paymentPerPeriod
    
}

print(payment(loanAmount: 20000, numOfPayments: 72, interestRate:0.044/12.0))

print(payment(loanAmount: 150000, numOfPayments: 30, interestRate: 0.05))
