//
//  MemoTableViewController.swift
//  MyMemoApp2
//
//  Created by 高木克 on 2022/06/09.
//

import UIKit

class MemoTableViewController: UITableViewController {
    
//    var memos = ["blue", "yellow", "red"]
    
    let userDefaules = UserDefaults.standard
    var memos = [String]()
    
//    saveボタン押下後に入力されたmemoをListに追加する
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue){
        guard let sourceVC = sender.source as? MemoViewController, let memo = sourceVC.memo else {
            return
        }
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.memos[selectedIndexPath.row] = memo
        } else {
            self.memos.append(memo)
        }
        self.userDefaules.set(self.memos, forKey: "memos")
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        userDefaulesはキーと値でデータを保持する
        if self.userDefaules.object(forKey: "memos") != nil {
//            文字列の配列をキーをmemosで呼び出す
            self.memos = self.userDefaules.stringArray(forKey: "memos")!
        } else {
            self.memos = ["memo1", "memo2", "memo3"]
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    表示する行数
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memos.count
    }

//    セルの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)
        cell.textLabel?.text = self.memos[indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

//    スワイプでメモの削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.memos.remove(at: indexPath.row)
            self.userDefaules.set(self.memos, forKey: "memos")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editMemo" {
            let memoVC = segue.destination as! MemoViewController
//            タップされている行が何行目か -> self.tableView.indexPathForSelectedRow?
            memoVC.memo = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }

}
