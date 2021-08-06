//
//  MasterViewController.swift
//  masterDetailTemplateXCode11
//
//  Created by R.O. Chapman on 11/18/20.
//  Copyright © 2020 R.O. Chapman. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var detailedBudgetInfoViewController: DetailedBudgetInfoViewController? = nil
    
    var BudgetData:[MonthlyBudgetInfo?] = []
    
    var selectedItem = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
            
//        let fileURL = self.dataFileURL(pathName: "BudgetData.plist")
//
//
//        if(FileManager.default.fileExists(atPath: fileURL.path)){
//            //initialize from the data file in the directory if there is one
//            print("found file")
//
//            do {
//                let data = try Data(contentsOf: fileURL)
//                let decoder = PropertyListDecoder()
//                let loadedData = try? decoder.decode([MonthlyBudgetInfo].self, from: data)
//                for element in loadedData? {
//                    BudgetData.insert(element, at: 0)
//                }
//                    print("loaded data")
//            }
//            catch{
//                print("couldn't archive")
//            }
//        }
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillTerminate(notification:)), name:UIApplication.willTerminateNotification, object: nil)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let monthlyBudgetData = MonthlyBudgetInfo(MonthAndYear: "Month and Year", EssentialBudget: "0", NonEssentialBudget: "0", Expense: [[:]])
        BudgetData.insert(monthlyBudgetData, at: 0)
        performSegue(withIdentifier: "createNewMonthEntry", sender: nil)
        //tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewMonthEntry" {
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            detailViewController = controller
            detailViewController!.masterController = self
            selectedItem = 0
            }
        if segue.identifier == "goToDetailedViewOfBudget"{
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailedBudgetInfoViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailedBudgetInfoViewController = controller
                detailedBudgetInfoViewController!.masterController = self
                selectedItem = indexPath.row
            }
        }
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {


        }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BudgetData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = BudgetData[indexPath.row]?.MonthAndYear
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        let itemToMove = BudgetData[sourceIndexPath.row]
       
        BudgetData.remove(at: sourceIndexPath.row)
        
        BudgetData.insert(itemToMove, at: destinationIndexPath.row)
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            BudgetData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToDetailedViewOfBudget", sender: nil)
    }
    
    func dataFileURL(pathName: String) -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url: URL?
        url = URL(fileURLWithPath: "")
        url = urls.first!.appendingPathComponent(pathName)
        return url!
    }

//    @objc func applicationWillResignActive(notification: NSNotification) {
//        
//        let archiveURL = self.dataFileURL(pathName: "BudgetData.plist")
//        let encoder = PropertyListEncoder()
//        
//        do {
//            for element in BudgetData {
//                let data = try encoder.encode(element)
//                try data.write(to: archiveURL)
//            }
//
//            print("saved data - resigning")
//        }
//        catch {
//            print("data couldn't be saved - resigning")
//        }
//    }
//        
//    @objc func applicationWillTerminate(notification: NSNotification) {
//        
//        let archiveURL = self.dataFileURL(pathName: "BudgetData.plist")
//        let encoder = PropertyListEncoder()
//        
//        do {
//            for element in BudgetData{
//                let data = try encoder.encode(element)
//                try data.write(to: archiveURL)
//            }
//            
//            print("saved data - terminating")
//        }
//        catch {
//            print("data couldn't be saved - terminating")
//        }
//        
//    }

}

