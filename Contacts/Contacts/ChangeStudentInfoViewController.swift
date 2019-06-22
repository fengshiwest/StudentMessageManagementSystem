//
//  ChangeStudentInfoViewController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/6/10.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class ChangeStudentInfoViewController: UIViewController {
    @IBOutlet weak var StudentName: UILabel!
    @IBOutlet weak var StudentNo: UITextField!
    @IBOutlet weak var StudentAcademy: UITextField!
    
    @IBOutlet weak var StudentIDNumber: UITextField!
    
    @IBOutlet weak var StudentPlace: UITextField!
    @IBOutlet weak var StudentPhoneNumber: UITextField!
    
    @IBOutlet weak var StudentMailbox: UITextField!
    
    @IBOutlet weak var SaveChangeStudentInfo: UIButton!
    
    let success = UIAlertController(title: "修改成功！", message: nil, preferredStyle: .alert)
    let fail = UIAlertController(title: "修改失败 请重试！", message: nil, preferredStyle: .alert)
    let yes = UIAlertAction(title: "确定", style: .default, handler: nil)
    
    var stu_name : String!
    var stu_no : String!
    var stu_academy : String!
    var stu_idnumber : String!
    var stu_place : String!
    var stu_phonenumber : String!
    var stu_mailbox : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StudentName.text = stu_name
        StudentNo.text = stu_no
        StudentAcademy.text = stu_academy
        StudentIDNumber.text = stu_idnumber
        StudentPlace.text = stu_place
        StudentPhoneNumber.text = stu_phonenumber
        StudentMailbox.text = stu_mailbox
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveOnClick(_ sender: UIButton) {
        let studentNo : String = StudentNo.text!
        let studentAcademy : String = StudentAcademy.text!
        let studentIDNumber : String = StudentIDNumber.text!
        let studentPlace : String = StudentPlace.text!
        let studentPhoneNumber : String = StudentPhoneNumber.text!
        let studentMailbox : String = StudentMailbox.text!
        
        let updateSQL = "UPDATE studentInfo SET stu_no = '\(studentNo)', stu_academy = '\(studentAcademy)', stu_idnumber = '\(studentIDNumber)', stu_place = '\(studentPlace)', stu_phonenumber = '\(studentPhoneNumber)', stu_mailbox = '\(studentMailbox)' WHERE stu_name = '\(stu_name!)';"
        print(updateSQL)
        if SQLManager.shareInstance().execSQL(SQL: updateSQL) == true {
            print("studentInfo数据更新成功")
            
            self.present(success,animated: true,completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            
        } else {
            print("studentInfo数据更新失败")
            fail.addAction(yes)
            self.present(fail,animated: true,completion: nil)
            
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTapGestureRecognized(_ sender: Any) {
        StudentNo.resignFirstResponder()
        StudentAcademy.resignFirstResponder()
        StudentIDNumber.resignFirstResponder()
        StudentPlace.resignFirstResponder()
        StudentPhoneNumber.resignFirstResponder()
        StudentMailbox.resignFirstResponder()
    }
}
