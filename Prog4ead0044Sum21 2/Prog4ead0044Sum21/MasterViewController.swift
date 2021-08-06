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
    //var objects = [String]()
    //var objectsDescription = [String]()
    var objectAndDescription: [[String:String]] = []
    var selectedItem = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
            
        let fileURL = self.dataFileURL()
        
        if(FileManager.default.fileExists(atPath: fileURL.path)){
            //initialize from the data file in the directory if there is one
            print("found file")
            objectAndDescription = (NSArray(contentsOf: fileURL as URL) as? [[String:String]])!
        }
        else{
            
            if let URL = Bundle.main.url(forResource: "Property List", withExtension: "plist") {
                if let arrayFromPlist = NSArray(contentsOf: URL) as? [Dictionary <String, String>] {
                    objectAndDescription = arrayFromPlist
                }
            }
        }
         
            NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object:nil)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc
    func insertNewObject(_ sender: Any) {
        //objects.insert("New Item", at: 0)
        //objectsDescription.insert("", at: 0)
        objectAndDescription.insert(["Title": "New Item"], at: 0)
        //let indexPath = IndexPath(row: 0, section: 0)
        performSegue(withIdentifier: "showDetail", sender: nil)
        //tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
                detailViewController!.masterController = self
                selectedItem = indexPath.row
            }
            else{
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
                detailViewController!.masterController = self
                selectedItem = 0
            }
        }
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {

        //objects.remove(at: 0)
        //objectsDescription.remove(at: 0)
        //tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .none)

        }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectAndDescription.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let object = objects[indexPath.row]
        cell.textLabel!.text = objectAndDescription[indexPath.row]["Title"]
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
        //let itemToMoveObject = objects[sourceIndexPath.row]
        //let itemToMoveDescription = objectsDescription[sourceIndexPath.row]
        let itemToMove = objectAndDescription[sourceIndexPath.row]
        //objects.remove(at: sourceIndexPath.row)
        //objectsDescription.remove(at: sourceIndexPath.row)
        objectAndDescription.remove(at: sourceIndexPath.row)
        //objects.insert(itemToMoveObject, at: destinationIndexPath.row)
        //objectsDescription.insert(itemToMoveDescription, at: destinationIndexPath.row)
        objectAndDescription.insert(itemToMove, at: destinationIndexPath.row)
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //objects.remove(at: indexPath.row)
            //objectsDescription.remove(at: indexPath.row)
            objectAndDescription.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url: URL?
        url = URL(fileURLWithPath: "")
        url = urls.first!.appendingPathComponent("data.plist")
        return url!
    }

    @objc func applicationWillResignActive(notification: NSNotification) {
        print("saved data")
        let fileURL = self.dataFileURL()
        let array = (self.objectAndDescription as NSArray)
        array.write(to: fileURL as URL, atomically: true)
    }

}

