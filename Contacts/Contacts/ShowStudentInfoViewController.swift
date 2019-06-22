//
//  ShowStudentInfoViewController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/6/10.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class ShowStudentInfoViewController: UIViewController {

    @IBOutlet weak var StudentName: UILabel!
    @IBOutlet weak var StudentNo: UILabel!
    @IBOutlet weak var StudentAcademy: UILabel!
    
    @IBOutlet weak var StudentIDNumber: UILabel!
    
    @IBOutlet weak var StudentPlace: UILabel!
    @IBOutlet weak var StudentPhoneNumber: UILabel!
    
    @IBOutlet weak var StudentMailbox: UILabel!
    
    @IBOutlet weak var ChangeStudentInfo: UIButton!
    
    @IBOutlet weak var DeleteStudentInfo: UIButton!
    
    
    var studentNoArr : Array<String> = []
    var studentAcademyArr : Array<String> = []
    var studentIDNumberArr : Array<String> = []
    var studentPlaceArr : Array<String> = []
    var studentPhoneNumberArr : Array<String> = []
    var studentMailboxArr : Array<String> = []
    
    var stu_name :String!
    var stu_no :String!
    var stu_academy : String!
    var stu_idnumber:String!
    var stu_place : String!
    var stu_phonenuber : String!
    var stu_mailbox : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        StudentName.text = stu_name
        StudentNo.text = stu_no
        StudentAcademy.text = stu_academy
        StudentIDNumber.text = stu_idnumber
        StudentPlace.text = stu_place
        StudentPhoneNumber.text = stu_phonenuber
        StudentMailbox.text = stu_mailbox
    }
    
    @IBAction func ChangeOnClick(_ sender: UIButton) {
        
    }
    @IBAction func DeleteOnClick(_ sender: UIButton) {
        let delete = UIAlertController(title: "确定要删除该学生信息吗？", message: nil, preferredStyle: .alert)
        
        let no = UIAlertAction(title: "取消", style: .default, handler: nil)
        let yes = UIAlertAction(title: "删除", style: .destructive, handler:{
            action in
            let deleteSQL = "DELETE FROM studentInfo WHERE stu_name = '\(self.stu_name!)';"
            print(deleteSQL)
            if SQLManager.shareInstance().execSQL(SQL: deleteSQL) == true {
                print("该学生信息已删除")
                let success = UIAlertController(title: "删除成功！", message: nil, preferredStyle: .alert)
                self.present(success,animated: true,completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.navigationController?.popToRootViewController(animated: true)
                    self.presentedViewController?.dismiss(animated: true, completion: nil)
                }
            }
            
        } )
        delete.addAction(no)
        delete.addAction(yes)
      
        self.present(delete,animated: true,completion: nil)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let changeStudentInfoViewController = segue.destination as! ChangeStudentInfoViewController
        changeStudentInfoViewController.stu_name = stu_name
        changeStudentInfoViewController.stu_no = stu_no
        changeStudentInfoViewController.stu_academy = stu_academy
        changeStudentInfoViewController.stu_idnumber = stu_idnumber
        changeStudentInfoViewController.stu_place = stu_place
        changeStudentInfoViewController.stu_phonenumber = stu_phonenuber
        changeStudentInfoViewController.stu_mailbox = stu_mailbox
    }
    

}
