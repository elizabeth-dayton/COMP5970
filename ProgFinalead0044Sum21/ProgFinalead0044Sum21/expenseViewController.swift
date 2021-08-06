//
//  expenseViewController.swift
//  ProgFinalead0044Sum21
//
//  Created by Elizabeth Dayton on 7/29/21.
//  Copyright © 2021 R.O. Chapman. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {
    
    @IBOutlet weak var expenseLabelTextField: UITextField!
    @IBOutlet weak var expenseAmountTextField: UITextField!
    
    var cancel: Bool!
    
    var detailedBudgetInfoViewController: DetailedBudgetInfoViewController!
    var masterController: MasterViewController!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        //expenseLabelTextField.text = masterController.BudgetData[detailedBudgetInfoViewController.selectedItem]!.Expense[detailedBudgetInfoViewController.selectedExpense]["Title"]
        //expenseAmountTextField.text = masterController.BudgetData[detailedBudgetInfoViewController.selectedItem]!.Expense[detailedBudgetInfoViewController.selectedExpense]["Amount"]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel , target: self, action: #selector(cancelButton(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save , target: self, action: #selector(saveButton(_:)))
        navigationItem.rightBarButtonItem = saveButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if cancel != true {
            
            masterController.BudgetData[detailedBudgetInfoViewController.masterController.selectedItem]?.Expense[detailedBudgetInfoViewController.selectedExpense]["Title"] = expenseLabelTextField!.text!
            masterController.BudgetData[detailedBudgetInfoViewController.masterController.selectedItem]?.Expense[detailedBudgetInfoViewController.selectedExpense]["Amount"] = expenseAmountTextField!.text!
        }
    }
    
    @objc func cancelButton(_ sender: Any) {
        cancel = true
        performSegue(withIdentifier:"unwindSegue", sender: self )

        }
    
    @objc func saveButton(_ sender: Any) {

            performSegue(withIdentifier:"unwindSegue", sender: self )

        }

}
