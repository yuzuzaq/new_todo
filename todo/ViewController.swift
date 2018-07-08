//
//  ViewController.swift
//  todo
//
//  Created by 森川彩音 on 2018/06/10.
//  Copyright © 2018年 森川彩音. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    // 追加
    var todoItem: Results<Birthday>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 追加
        // 永続化されているデータを取りだす
        do{
            let realm = try Realm()
            todoItem = realm.objects(Birthday.self)
            tableView.reloadData()
        }catch{
            
        }
        
    }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
            return todoItem.count
        }

        func tableView(tableView: UITableView, cellForRowAtIndexPath indexpath: NSIndexPath)->UITableViewCell {
            
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
            let object = todoItem[indexpath.row]
            
            //cellのtextLabelのtextにobjectのtitleプロパティを代入
            cell.textLabel?.text = object.name
            
            return cell
        }
    
    // 追加 画面が表示される際などにtableViewのデータを再読み込みする
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
}
