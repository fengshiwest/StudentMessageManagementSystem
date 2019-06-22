//
//  ScoreResultTableViewController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/6/12.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class ScoreResultTableViewController: UITableViewController {
    
    var stuScoreArr : Array<String> = []
    var studentName : String = ""

    var courseNameArr : Array<String> = ["学生姓名","高等数学","大学英语","大学物理","Java程序设计","数据结构","操作系统","Objective-C","大学体育"]
    var columnNameArr : Array<String> = ["stu_name","math","english","physics","java","ds","os","oc","pe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTableViewData()
    }

    func loadTableViewData() {
        let selectSQL = "SELECT stu_name, math, english, physics, java, ds, os, oc, pe FROM studentScore WHERE stu_name = '\(studentName)';"
        let resultArr = SQLManager.shareInstance().queryDataBase(querySQL: selectSQL)
        stuScoreArr = []
        for dict in resultArr! {
            stuScoreArr.append(dict["stu_name"] as! String)
            stuScoreArr.append(dict["math"] as! String)
            stuScoreArr.append(dict["english"] as! String)
            stuScoreArr.append(dict["physics"] as! String)
            stuScoreArr.append(dict["java"] as! String)
            stuScoreArr.append(dict["ds"] as! String)
            stuScoreArr.append(dict["os"] as! String)
            stuScoreArr.append(dict["oc"] as! String)
            stuScoreArr.append(dict["pe"] as! String)
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)

        let courseNameLabel = cell.viewWithTag(1) as! UILabel
        courseNameLabel.text = courseNameArr[indexPath.row + 1]
        
        let scoreLabel = cell.viewWithTag(2) as! UILabel
        scoreLabel.text = stuScoreArr[indexPath.row + 1]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var inputText : UITextField = UITextField()
        let msgAlertCtr = UIAlertController.init(title:"修改成绩",message:"请重新输入分数",preferredStyle:.alert)
        let ok = UIAlertAction.init(title:"确定", style:.default){(action:UIAlertAction)->()in
            if(inputText.text != nil){
                let newScore = inputText.text
                let updateSQL = "UPDATE studentScore SET \(self.columnNameArr[indexPath.row + 1]) = '\(newScore!)' WHERE stu_name = '\(self.studentName)';"
                print(updateSQL)
                if SQLManager.shareInstance().execSQL(SQL: updateSQL) == true {
                    print("数据库中分数修改成功")
                    
                    let success = UIAlertController(title: "修改成功！", message: nil, preferredStyle: .alert)
                    
                    self.present(success,animated: true,completion: nil)
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.presentedViewController?.dismiss(animated: true, completion: nil)
                    }
                } else {
                    print("数据库中分数修改失败")
                    let fail = UIAlertController(title: "修改失败 请重试！", message: nil, preferredStyle: .alert)
                    self.present(fail,animated: true,completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.presentedViewController?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
            
        let cancel = UIAlertAction.init(title:"取消", style:.default) {(action:UIAlertAction)->()in
            self.navigationController?.popViewController(animated: true)
        }
            
        msgAlertCtr.addAction(ok)
        msgAlertCtr.addAction(cancel)
        msgAlertCtr.addTextField{(textField) in
            inputText = textField
        }
        self.present(msgAlertCtr,animated: true,completion: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
