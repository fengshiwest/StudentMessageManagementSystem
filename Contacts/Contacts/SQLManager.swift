//
//  SQLManager.swift
//  Contacts
//
//  Created by fengshiwest on 2019/6/5.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

let DBFILE1_NAME = "teacher.sqlite"
let DBFILE2_NAME = "studentInfo.sqlite"
let DBFILE3_NAME = "studentScore.sqlite"

public class SQLManager : NSObject {
    // 创建该类的静态实例变量
    static let instance = SQLManager();
    // 定义数据库变量
    var db1 : OpaquePointer? = nil
    var db2 : OpaquePointer? = nil
    var db3 : OpaquePointer? = nil
    // 对外提供创建单例对象的接口
     let documentPath1 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
    let documentPath2 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
    let documentPath3 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
    
    let createTeacherTableSQL = "CREATE TABLE IF NOT EXISTS teacher (username INTEGER NOT NULL PRIMARY KEY, password INTEGER);"
    
    let createStudentInfoTableSQL = "CREATE TABLE IF NOT EXISTS studentInfo (stu_name TEXT NOT NULL PRIMARY KEY, stu_no TEXT, stu_academy TEXT, stu_idnumber TEXT, stu_place TEXT, stu_phonenumber TEXT, stu_mailbox TEXT);"
    
    let createStudentScoreTableSQL = "CREATE TABLE IF NOT EXISTS studentScore (stu_name TEXT NOT NULL PRIMARY KEY, math TEXT, english TEXT, physics TEXT, java TEXT, ds TEXT, os TEXT, oc TEXT, pe TEXT);"
    
    class func shareInstance() -> SQLManager {
        return instance
    }
    
    // 获取teacher数据库文件的路径
    func getTeacherFilePath() -> String {
        let DBPath = (documentPath1! as NSString).appendingPathComponent(DBFILE1_NAME)
        print("数据库的地址是：\(DBPath)")
        return DBPath
    }
    
    func getStudentInfoFilePath() -> String {
        let DBPath = (documentPath2! as NSString).appendingPathComponent(DBFILE2_NAME)
        print("数据库的地址是：\(DBPath)")
        return DBPath
    }
    
    func getStudentScoreFilePath() ->String {
        let DBPath = (documentPath3! as NSString).appendingPathComponent(DBFILE3_NAME)
        print("数据库的地址是：\(DBPath)")
        return DBPath
        
    }
    
    func createTeacherDataBaseTableIfNeeded() {
        // 只接受C语言的字符串，所以要把DBPath这个NSString类型的转换为cString类型，用UTF8的形式表示
        let cDBPath = getTeacherFilePath().cString(using: String.Encoding.utf8)
        
        // 第一个参数：数据库文件路径，这里是我们定义的cDBPath
        // 第二个参数：数据库对象，这里是我们定义的db
        // SQLITE_OK是SQLite内定义的宏，表示成功打开数据库
        if sqlite3_open(cDBPath, &db1) != SQLITE_OK {
            // 失败
            print("教师数据库打开失败~！")
        } else {
            // 创建表的SQL语句
            print("教师数据库打开成功~！")
           
            if execSQL(SQL: createTeacherTableSQL) == false {
                // 失败
                print("执行创建teacher表的SQL语句出错~")
            } else {
                print("创建teacher表的SQL语句执行成功！")
            }
            
        }
    }
    
    func createStudentInfoDataBaseTableIfNeeded() {
        // 只接受C语言的字符串，所以要把DBPath这个NSString类型的转换为cString类型，用UTF8的形式表示
        let cDBPath = getStudentInfoFilePath().cString(using: String.Encoding.utf8)
        
        // 第一个参数：数据库文件路径，这里是我们定义的cDBPath
        // 第二个参数：数据库对象，这里是我们定义的db
        // SQLITE_OK是SQLite内定义的宏，表示成功打开数据库
        if sqlite3_open(cDBPath, &db2) != SQLITE_OK {
            // 失败
            print("学生信息数据库打开失败~！")
        } else {
            // 创建表的SQL语句
            print("学生信息数据库打开成功~！")
            
            if execSQL(SQL: createStudentInfoTableSQL) == false {
                // 失败
                print("执行创建studentInfo表的SQL语句出错~")
            } else {
                print("创建studentInfo表的SQL语句执行成功！")
            }
            
            
        }
    }
    
    func createStudentScoreDataBaseTableIfNeeded() {
        // 只接受C语言的字符串，所以要把DBPath这个NSString类型的转换为cString类型，用UTF8的形式表示
        let cDBPath = getStudentScoreFilePath().cString(using: String.Encoding.utf8)
        
        // 第一个参数：数据库文件路径，这里是我们定义的cDBPath
        // 第二个参数：数据库对象，这里是我们定义的db
        // SQLITE_OK是SQLite内定义的宏，表示成功打开数据库
        if sqlite3_open(cDBPath, &db3) != SQLITE_OK {
            // 失败
            print("学生成绩数据库打开失败~！")
        } else {
            // 创建表的SQL语句
            print("学生成绩数据库打开成功~！")
            
            if execSQL(SQL: createStudentScoreTableSQL) == false {
                // 失败
                print("执行创建studentScore表的SQL语句出错~")
            } else {
                print("创建studentScore表的SQL语句执行成功！")
            }
        }
    }
    
    // 查询数据库，传入SQL查询语句，返回一个字典数组
    func queryDataBase(querySQL : String) -> [[String : AnyObject]]? {
        // 创建一个语句对象
        var statement : OpaquePointer? = nil
        
        if querySQL.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            let cQuerySQL = (querySQL.cString(using: String.Encoding.utf8))!
            // 进行查询前的准备工作
            // 第一个参数：数据库对象，第二个参数：查询语句，第三个参数：查询语句的长度（如果是全部的话就写-1），第四个参数是：句柄（游标对象）
            if sqlite3_prepare_v2(db1, cQuerySQL, -1, &statement, nil) == SQLITE_OK {
                var queryDataArr = [[String: AnyObject]]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    // 获取解析到的列
                    let columnCount = sqlite3_column_count(statement)
                    // 遍历某行数据
                    var temp = [String : AnyObject]()
                    for i in 0..<columnCount {
                        // 取出i位置列的字段名,作为temp的键key
                        let cKey = sqlite3_column_name(statement, i)
                        let key : String = String(validatingUTF8: cKey!)!
                        //取出i位置存储的值,作为字典的值value
                        let cValue = sqlite3_column_text(statement, i)
                        let value = String(cString: cValue!)
                        temp[key] = value as AnyObject
                    }
                    queryDataArr.append(temp)
                }
                return queryDataArr
            }
            
            if sqlite3_prepare_v2(db2, cQuerySQL, -1, &statement, nil) == SQLITE_OK {
                var queryDataArr = [[String: AnyObject]]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    // 获取解析到的列
                    let columnCount = sqlite3_column_count(statement)
                    // 遍历某行数据
                    var temp = [String : AnyObject]()
                    for i in 0..<columnCount {
                        // 取出i位置列的字段名,作为temp的键key
                        let cKey = sqlite3_column_name(statement, i)
                        let key : String = String(validatingUTF8: cKey!)!
                        //取出i位置存储的值,作为字典的值value
                        let cValue = sqlite3_column_text(statement, i)
                        let value = String(cString: cValue!)
                        temp[key] = value as AnyObject
                    }
                    queryDataArr.append(temp)
                }
                return queryDataArr
            }
            
            if sqlite3_prepare_v2(db3, cQuerySQL, -1, &statement, nil) == SQLITE_OK {
                var queryDataArr = [[String: AnyObject]]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    // 获取解析到的列
                    let columnCount = sqlite3_column_count(statement)
                    // 遍历某行数据
                    var temp = [String : AnyObject]()
                    for i in 0..<columnCount {
                        // 取出i位置列的字段名,作为temp的键key
                        let cKey = sqlite3_column_name(statement, i)
                        let key : String = String(validatingUTF8: cKey!)!
                        //取出i位置存储的值,作为字典的值value
                        let cValue = sqlite3_column_text(statement, i)
                        let value = String(cString: cValue!)
                        temp[key] = value as AnyObject
                    }
                    queryDataArr.append(temp)
                }
                return queryDataArr
            }
        }
        return nil
    }
    
    // 执行SQL语句的方法，传入SQL语句执行
    func execSQL(SQL : String) -> Bool {
        let cSQL = SQL.cString(using: String.Encoding.utf8)
        let errmsg : UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil
        if sqlite3_exec(db1, cSQL, nil, nil, errmsg) == SQLITE_OK {
            return true
        } else {
            print(errmsg)
            return false
        }
        
        if sqlite3_exec(db2, cSQL, nil, nil, errmsg) == SQLITE_OK {
            return true
        } else {
            print(errmsg)
            return false
        }
        
        if sqlite3_exec(db3, cSQL, nil, nil, errmsg) == SQLITE_OK {
            return true
        } else {
            print(errmsg)
            return false
        }
    }
}
