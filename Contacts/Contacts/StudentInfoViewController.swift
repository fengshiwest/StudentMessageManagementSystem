//
//  StudentInfoViewController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/5/30.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class StudentInfoViewController: UIViewController {

    @IBOutlet weak var StudentName: UITextField!
    @IBOutlet weak var StudentNo: UITextField!
    @IBOutlet weak var StudentAcademy: UITextField!
    @IBOutlet weak var StudentIDNumber: UITextField!
    @IBOutlet weak var StudentPlace: UITextField!
    @IBOutlet weak var StudentPhoneNumber: UITextField!
    @IBOutlet weak var StudentMailbox: UITextField!
    @IBOutlet weak var ChangeStudentInfo: UIButton!
    @IBOutlet weak var DeleteStudentInfo: UIButton!
    
    let success = UIAlertController(title: "添加成功！", message: nil, preferredStyle:.alert)
    let fail = UIAlertController(title: "添加失败 请重试！", message: nil, preferredStyle: .alert)
    let yes = UIAlertAction(title: "确定", style: .default, handler: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveOnClick(_ sender: UIButton) {
        let studentName : String = StudentName.text!
        let studentNo : String = StudentNo.text!
        let studentAcademy : String = StudentAcademy.text!
        let studentIDNumber : String = StudentIDNumber.text!
        let studentPlace : String = StudentPlace.text!
        let studentPhoneNumber : String = StudentPhoneNumber.text!
        let studentMailbox : String = StudentMailbox.text!
        
        let insertSQL = "INSERT INTO studentInfo (stu_name, stu_no, stu_academy, stu_idnumber, stu_place, stu_phonenumber, stu_mailbox) VALUES ('\(studentName)','\(studentNo)','\(studentAcademy)','\(studentIDNumber)','\(studentPlace)','\(studentPhoneNumber)','\(studentMailbox)');"
        print(insertSQL)
        
        let insertScoreSQL = "INSERT INTO studentScore (stu_name, math, english, physics, java, ds, os, oc, pe) VALUES ('\(studentName)','90','90','90','90','90','90','90','90'); "
        print(insertScoreSQL)
        
        if SQLManager.shareInstance().execSQL(SQL: insertScoreSQL) == true {
            print("插入studentScore学生分数数据添加成功")
        } else {
            print("插入studentScore学生分数数据添加失败")
        }
        
        if SQLManager.shareInstance().execSQL(SQL: insertSQL) == true {
            print("插入studentInfo数据添加成功")
            
            self.present(success,animated: true,completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                
            }
            
            
        } else {
            print("插入studentInfo数据添加失败")
            fail.addAction(yes)
            self.present(fail,animated: true,completion: nil)
            
        }
        
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        StudentName.resignFirstResponder()
        StudentNo.resignFirstResponder()
        StudentAcademy.resignFirstResponder()
        StudentIDNumber.resignFirstResponder()
        StudentPlace.resignFirstResponder()
        StudentPhoneNumber.resignFirstResponder()
        StudentMailbox.resignFirstResponder()
    }
    
}
