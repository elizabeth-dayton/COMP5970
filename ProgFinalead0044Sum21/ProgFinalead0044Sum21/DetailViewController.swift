//
//  DetailViewController.swift
//  masterDetailTemplateXCode11
//
//  Created by R.O. Chapman on 11/18/20.
//  Copyright © 2020 R.O. Chapman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var masterController: MasterViewController!
    var cancel: Bool!

    @IBOutlet weak var monthAndYearTextField: UITextField!
    
    @IBOutlet weak var essentialBudgetTextField: UITextField!
    
    @IBOutlet weak var nonEssentialBudgetTextField: UITextField!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        monthAndYearTextField.text = masterController.BudgetData[masterController.selectedItem]?.MonthAndYear
        essentialBudgetTextField.text = masterController.BudgetData[masterController.selectedItem]?.EssentialBudget
        nonEssentialBudgetTextField.text = masterController.BudgetData[masterController.selectedItem]?.NonEssentialBudget
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel , target: self, action: #selector(cancelButton(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save , target: self, action: #selector(saveButton(_:)))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if cancel != true {
            
            masterController.BudgetData[masterController.selectedItem]?.MonthAndYear = monthAndYearTextField!.text!
            masterController.BudgetData[masterController.selectedItem]?.EssentialBudget = essentialBudgetTextField!.text!
            masterController.BudgetData[masterController.selectedItem]?.NonEssentialBudget = nonEssentialBudgetTextField!.text!
        }
    }

    @objc func cancelButton(_ sender: Any) {
        cancel = true
        performSegue(withIdentifier:"unwindSegue", sender: self )

        }
    
    @objc func saveButton(_ sender: Any) {

            performSegue(withIdentifier:"unwindSegue", sender: self )

        }
    
//    var detailItem: NSDate? {
//        didSet {
//            // Update the view.
//            configureView()
//        }
//    }


}

