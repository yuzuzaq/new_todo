//
//  MemoViewController.swift
//  todo
//
//  Created by 森川彩音 on 2018/06/10.
//  Copyright © 2018年 森川彩音. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class MemoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var birthmonthTextField: UITextField!
    @IBOutlet var birthdayTextField: UITextField!
    let realm = try! Realm()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameTextField.text = saveData.string(forKey: "myText"+memoNo)
//        titleTextField.text = saveData.object(forKey: "title") as? String
//        contentTextView.text = saveData.object(forKey: "content")as? String
        //nameTextField.delegate = self
        
        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveMemo() {
        
        let birthdaytable = Birthday()
        
        // textFieldに入力したデータをnewTodoのtitleに代入
        birthdaytable.name = nameTextField.text!
        birthdaytable.month = Int(birthmonthTextField.text!)!
        birthdaytable.day = Int(birthdayTextField.text!)!
        
        try! realm.write() {
            realm.add(birthdaytable)
        }
        print(birthdaytable)
//        birthdaytable.title = nameTextField.text!
        
        
        // 上記で代入したテキストデータを永続化するための処理
//        do{
//            let realm = try Realm()
//            try realm.write({ () -> Void in
//                realm.add(birthdaytable)
//                print("ToDo Saved")
//            })
//        }catch{
//            print("Save is Faild")
//        }
      self.navigationController?.popToRootViewController(animated: true)
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

