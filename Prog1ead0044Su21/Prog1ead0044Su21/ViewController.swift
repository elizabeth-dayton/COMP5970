//
//  ViewController.swift
//  Prog1ead0044Su21
//
//  Created by Elizabeth Dayton on 6/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageOutlet.image = UIImage(named: "SECLogo")
    }
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var auburnButtonOutlet: UIButton!
    
    @IBOutlet weak var secButtonOutlet: UIButton!
   
    @IBOutlet weak var bamaButtonOutlet: UIButton!
    
    
    @IBAction func auburnButtonController(_ sender: UIButton!) {
        imageOutlet.image = UIImage(named: "AuburnLogo")
    }
    
    @IBAction func secButtonController(_ sender: UIButton!) {
        imageOutlet.image = UIImage(named: "SECLogo")
    }
    
    @IBAction func bamaButtonController(_ sender: UIButton!) {
        imageOutlet.image = UIImage(named: "AlabamaLogo")
        
    }
    
}

