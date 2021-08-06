//
//  DetailedBudgetInfoViewController.swift
//  ProgFinalead0044Sum21
//
//  Created by Elizabeth Dayton on 7/29/21.
//  Copyright © 2021 R.O. Chapman. All rights reserved.
//

import UIKit

class DetailedBudgetInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var essentialRemainingText: UILabel!
    
    @IBOutlet weak var nonessentialRemainingText: UILabel!
    
    @IBOutlet weak var expenseTableView: UITableView!
    
    var masterController: MasterViewController!
    var detailedBudgetInfoViewController: DetailedBudgetInfoViewController? = nil
    var expenseViewController: ExpenseViewController? = nil
    var selectedExpense = 0
    
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(false, animated: true)
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        essentialRemainingText.text = masterController.BudgetData[masterController.selectedItem]?.EssentialBudget
        nonessentialRemainingText.text = masterController.BudgetData[masterController.selectedItem]?.NonEssentialBudget
    }
    
    @objc func insertNewObject(_ sender: Any) {
        
        masterController.BudgetData[masterController.selectedItem]?.Expense.insert(["New Expense" : "0"], at: 0)
        performSegue(withIdentifier: "addExpense", sender: nil)
        //tableView.insertRows(at: [indexPath], with: .automatic)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addExpense" {
            let controller = (segue.destination as! UINavigationController).topViewController as! ExpenseViewController
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            expenseViewController = controller
            expenseViewController!.detailedBudgetInfoViewController = self
            expenseViewController!.masterController = masterController
            selectedExpense = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        expenseTableView.reloadData()
    }
    
    func tableView(_ expenseTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expenseTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = masterController.BudgetData[masterController.selectedItem]?.Expense[indexPath.row]["Title"]
        cell.detailTextLabel!.text = masterController.BudgetData[masterController.selectedItem]?.Expense[indexPath.row]["Amount"]
        return cell
    }
    
    func numberOfSections(in expenseTableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ expenseTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masterController.BudgetData[masterController.selectedItem]?.Expense.count ?? 0
    }
    
    func tableView(_ expenseTableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ expenseTableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            masterController.BudgetData.remove(at: indexPath.row)
            expenseTableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(_ expenseTableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        let itemToMove = masterController.BudgetData[sourceIndexPath.row]
       
        masterController.BudgetData.remove(at: sourceIndexPath.row)
        
        masterController.BudgetData.insert(itemToMove, at: destinationIndexPath.row)
        
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {}

}
