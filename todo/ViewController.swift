//
//  ViewController.swift
//  todo
//
//  Created by 森川彩音 on 2018/06/10.
//  Copyright © 2018年 森川彩音. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDataSource{
    
    // 追加
    var todoItem: Results<Birthday>!
    
    @IBOutlet weak var mainTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        
        // 追加
        // 永続化されているデータを取りだす
        do{
            let realm = try Realm()
            todoItem = realm.objects(Birthday.self)
            mainTable.reloadData()
        }catch{
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
//        return todoItem.count
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return todoItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//                let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
//                let object = todoItem[indexpath.row]
        
                //cellのtextLabelのtextにobjectのtitleプロパティを代入
//                cell.textLabel?.text = object.name
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: <#T##IndexPath#>)
        cell.textLabel?.text = "sample"
        
                return cell
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexpath: IndexPath)->UITableViewCell {
//        
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
//        let object = todoItem[indexpath.row]
//        
//        //cellのtextLabelのtextにobjectのtitleプロパティを代入
//        cell.textLabel?.text = object.name
//        
//        return cell
//    }
    
    // 追加 画面が表示される際などにtableViewのデータを再読み込みする
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTable.reloadData()
        
    }
}
