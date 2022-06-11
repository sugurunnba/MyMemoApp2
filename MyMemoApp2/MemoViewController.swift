//
//  MemoViewController.swift
//  MyMemoApp2
//
//  Created by 高木克 on 2022/06/09.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var memo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.saveButton.isEnabled = false
        
        if let memo = self.memo {
            self.memoTextField.text = memo
            self.updateSaveButtonState()
            self.navigationItem.title = "Edit Memo"
        }
    }
    
    private func updateSaveButtonState() {
        let memo = self.memoTextField.text ?? ""
        self.saveButton.isEnabled = !memo.isEmpty
    }
    
    @IBAction func memoTextFieldChanged(_ sender: Any) {
        self.updateSaveButtonState()
    }
    
    @IBAction func cancelMethod(_ sender: Any) {
//        モーダルで画面を表示している際、presentingViewControllerにモーダルを表示しているViewControllerが入る
//        isは型チェック
        if self.presentingViewController is UINavigationController {
            //モーダルを閉じる処理
            self.dismiss(animated: true, completion: nil)
        } else {
//            showで表示している画面を閉じる
            self.navigationController?.popViewController(animated: true)
        }

    }

//    セグエが実行される前に走るメソッド
//    saveボタンを押した際、senderにsaveButtonが渡される
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            return
        }
        self.memo = self.memoTextField.text ?? ""
    }

}
