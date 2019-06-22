//
//  RegisterViewController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/6/5.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var passWordAgain: UITextField!
    
    
    @IBOutlet weak var register: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func registerOnClick(_ sender: UIButton) {
        let username:Int = Int(userName.text!)!
        let password :Int = Int(passWord.text!)!
        let passwordagain :Int = Int(passWordAgain.text!)!
        print(username)
        print(password)
        print(passwordagain)
        
        let success = UIAlertController(title: "\(username),恭喜你注册成功！", message: nil, preferredStyle: .alert)
        let fail = UIAlertController(title: "前后密码不一致，请重新设置", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "确定", style: .default, handler: nil)
        
        if(password == passwordagain) {
            let insertSQL = "INSERT INTO teacher (username,password) VALUES (\(username), \(password));"
            print(insertSQL)
            if SQLManager.shareInstance().execSQL(SQL: insertSQL) == true {
                print("教师数据添加成功")
                success.addAction(yes)
                self.present(success,animated: true,completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.presentedViewController?.dismiss(animated: true, completion: nil)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                print("教师数据添加失败")
                
            }
        }
        else {
            fail.addAction(yes)
            self.present(fail,animated: true,completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: true, completion: nil)
                //self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    }
    

    @IBAction func onTapGestureRecognized(_ sender: Any) {
        userName.resignFirstResponder()
        passWord.resignFirstResponder()
        passWordAgain.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
