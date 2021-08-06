//
//  DetailViewController.swift
//  masterDetailTemplateXCode11
//
//  Created by R.O. Chapman on 11/18/20.
//  Copyright © 2020 R.O. Chapman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var masterController: MasterViewController!
    var cancel: Bool!

    @IBOutlet weak var itemTitleTextField: UITextField!
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        itemDescriptionTextView.text = masterController.objectsDescription[masterController.selectedItem]
        itemTitleTextField.text = masterController.objects[masterController.selectedItem]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        itemDescriptionTextView.layer.borderWidth = 0.5
        itemDescriptionTextView.layer.borderColor = borderColor.cgColor
        itemDescriptionTextView.layer.cornerRadius = 5.0
        
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
        masterController.objects[masterController.selectedItem] = itemTitleTextField!.text!
        masterController.objectsDescription[masterController.selectedItem] = itemDescriptionTextView!.text!
        }
    }

    @objc func cancelButton(_ sender: Any) {
        cancel = true
        performSegue(withIdentifier:"unWindSegue", sender: self )

        }
    
    @objc func saveButton(_ sender: Any) {

            performSegue(withIdentifier:"unWindSegue", sender: self )

        }
//    var detailItem: NSDate? {
//        didSet {
//            // Update the view.
//            configureView()
//        }
//    }


}

