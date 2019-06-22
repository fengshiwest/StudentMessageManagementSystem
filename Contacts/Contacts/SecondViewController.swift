//
//  SecondViewController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/5/14.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var studentName : String = ""
    
    @IBOutlet weak var StudentName: UITextField!
    @IBOutlet weak var SearchScore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func SearchScoreOnClick(_ sender: UIButton) {
        studentName = StudentName.text!
        let scoreResultVC = storyboard?.instantiateViewController(withIdentifier: "ScoreResult") as! ScoreResultTableViewController
        scoreResultVC.studentName = studentName
    
        self.navigationController?.pushViewController(scoreResultVC, animated: true)
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        StudentName.resignFirstResponder()
    }
    
    
}

