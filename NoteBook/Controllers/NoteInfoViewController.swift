//
//  NoteInfoViewController.swift
//  NoteBook
//
//  Created by 云联 on 2026/5/20.
//

import UIKit
import SnapKit
class NoteInfoViewController: UIViewController {
    
    //当前编辑的记事数据模型
    var noteModel: NoteModel?
    
    //记事分组
    var group: String?
    
    var isNew = false
    
    
  func setupNavigationItems() {
      let deleteImage = UIImage(systemName: "trash",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16))
      let deleteItem = UIBarButtonItem(image: deleteImage, style: .plain, target: self, action: #selector(handlerDelete))
      let saveItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(handerSave))
      navigationItem.rightBarButtonItems = [saveItem,deleteItem]
      
    }
    
    //删除一条记事内容
   @objc func handlerDelete() {
       if !isNew {
           DataManager.deleteNote(note: noteModel!)
           self.navigationController?.popViewController(animated: true)
       }
    }
    
   @objc func handerSave() {
       
       //如果是新建记事，进行数据库的新增
       if isNew {
           if titleTextField.text != nil && titleTextField.text!.count > 0 {
               noteModel = NoteModel()
               noteModel?.title = titleTextField.text!
               noteModel?.body = contentTextView.text
               //将当前时间进行格式化
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd HH:mm ss"
               noteModel?.time = dateFormatter.string(from: Date())
               noteModel?.group = group
               DataManager.addNote(note: noteModel!)
               self.navigationController?.popViewController(animated: true)
           }
           
       }else{
           //更新记事
           if titleTextField.text != nil && titleTextField.text!.count > 0 {
               noteModel?.title = titleTextField.text
               noteModel?.body = contentTextView.text
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd HH:mm ss"
               noteModel?.time = dateFormatter.string(from: Date())
               DataManager.updateNote(note: noteModel!)
               self.navigationController?.popViewController(animated: true)
           }
           
       }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.addSubview(self.titleTextField)
        self.view.addSubview(self.contentTextView)
        self.titleTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
        }
        self.contentTextView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(self.titleTextField.snp.bottom).offset(12)
            make.height.equalTo(300)
        }
                
        self.titleTextField.text = noteModel?.title
        self.contentTextView.text = noteModel?.body
        
    }
    
    lazy var titleTextField: UITextField = {
        titleTextField = UITextField()
        titleTextField.borderStyle = .roundedRect
        titleTextField.placeholder = "请输入标题"
        return titleTextField
    }()
    
    lazy var contentTextView: UITextView = {
         contentTextView = UITextView()
        contentTextView.layer.borderWidth = 1;
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        return contentTextView
    }()

}
