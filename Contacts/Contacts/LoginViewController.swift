//
//  LoginViewController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/6/5.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    
    @IBOutlet weak var register: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginOnClick(_ sender: UIButton) {
        let username  = userName.text!
        let password :Int = (Int)(passWord.text!)!
        
        let success = UIAlertController(title: "\(username),欢迎你！", message: nil, preferredStyle: .alert)
        let fail = UIAlertController(title: "用户名或密码错误 请重新输入", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "确定", style: .default, handler: nil)
        
        let selectSQL = "SELECT password FROM teacher WHERE username = " + username + ";"
        let result = SQLManager.shareInstance().queryDataBase(querySQL: selectSQL)
        
        //TODO
        if(result != nil) {
            print("登录成功")
            print(password)
            success.addAction(yes)
            self.present(success,animated: true,completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.presentedViewController?.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        else {
            print("登录失败")
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
