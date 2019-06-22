//
//  FirstViewController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/5/14.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController{
  

    var studentNameArr : Array<String> = []
    var studentNoArr : Array<String> = []
    var studentAcademyArr : Array<String> = []
    var studentIDNumberArr : Array<String> = []
    var studentPlaceArr : Array<String> = []
    var studentPhoneNumberArr : Array<String> = []
    var studentMailboxArr : Array<String> = []
    
    //let studentInfoTableIdentifier = "StudentInfoTableIndentifier"
    var names: [String] = []

    var searchController: UISearchController!
    
   
    override func viewDidLoad() {
        Thread.sleep(forTimeInterval:2.0)
        
        super.viewDidLoad()
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: studentInfoTableIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let selectSQL = "SELECT stu_name,stu_no,stu_academy,stu_idnumber,stu_place,stu_phonenumber,stu_mailbox FROM 'studentInfo';"
        let result = SQLManager.shareInstance().queryDataBase(querySQL: selectSQL)
        print(result as Any)
        studentNameArr = []
        studentNoArr = []
        studentAcademyArr = []
        studentIDNumberArr = []
        studentPlaceArr = []
        studentPhoneNumberArr = []
        studentMailboxArr = []
        
        for dict in result! {
            studentNameArr.append(dict["stu_name"]! as! String)
            studentNoArr.append(dict["stu_no"]! as! String)
            studentAcademyArr.append(dict["stu_academy"]! as! String)
            studentIDNumberArr.append(dict["stu_idnumber"]! as! String)
            studentPlaceArr.append(dict["stu_place"]! as! String)
            studentPhoneNumberArr.append(dict["stu_phonenumber"]! as! String)
            studentMailboxArr.append(dict["stu_mailbox"]! as! String)
            
        }
        
        
        names = studentNameArr
        
        let resultsController = SearchResultsController()
        resultsController.names = names
        searchController = UISearchController(searchResultsController: resultsController)
        let searchBar = searchController.searchBar
        searchBar.placeholder = "输入学生姓名以查询信息"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
        tableView.reloadData()

    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentNameArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for:indexPath)
        let studentName = cell.viewWithTag(1) as! UILabel
        studentName.text = studentNameArr[indexPath.row]
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowStudentInfo" {
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let showStudentInfoViewController = segue.destination as! ShowStudentInfoViewController
            
            showStudentInfoViewController.stu_name = studentNameArr[indexPath.row]
            showStudentInfoViewController.stu_no = studentNoArr[indexPath.row]
            showStudentInfoViewController.stu_academy = studentAcademyArr[indexPath.row]
            showStudentInfoViewController.stu_idnumber = studentIDNumberArr[indexPath.row]
            showStudentInfoViewController.stu_place = studentPlaceArr[indexPath.row]
            showStudentInfoViewController.stu_phonenuber = studentPhoneNumberArr[indexPath.row]
            showStudentInfoViewController.stu_mailbox = studentMailboxArr[indexPath.row]
            
        }
    }
   
}

