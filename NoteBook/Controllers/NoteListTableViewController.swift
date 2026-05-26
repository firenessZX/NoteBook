//
//  NoteListTableViewController.swift
//  NoteBook
//
//  Created by 云联 on 2026/5/20.
//

import UIKit

class NoteListTableViewController: UITableViewController {

    var dataArray = Array<NoteModel>()
    //当前分组
    var groupName: String?
    
    func setupNavItems() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange
        appearance.titleTextAttributes = [.foregroundColor:UIColor.white,.font:UIFont.systemFont(ofSize: 18)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = groupName
        let plusImage = UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let addItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(addNoteOperation))
        let deleteImage = UIImage(systemName: "trash",withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let deleteItem = UIBarButtonItem(image: deleteImage, style: .plain, target: self, action: #selector(deleteOperation))
        navigationItem.rightBarButtonItems = [addItem,deleteItem]
        
    }
    
  @objc func addNoteOperation()  {
      let infoVC = NoteInfoViewController()
      infoVC.group = groupName!
      infoVC.isNew = true
      self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
   @objc func deleteOperation() {
       DataManager.deleteGroup(name: groupName!)
       self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataArray = DataManager.getNote(group: groupName!)
        self.tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:UITableViewCell.reuseID)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.reuseID)
        }
        let model = self.dataArray[indexPath.row]
        var listConfig =  cell?.defaultContentConfiguration()
        listConfig?.text = model.title
        listConfig?.secondaryText = model.time
        cell?.contentConfiguration = listConfig
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataArray[indexPath.row]
        let infoVC = NoteInfoViewController()
        infoVC.group = model.group!
        infoVC.isNew = false
        infoVC.noteModel = model
        self.navigationController?.pushViewController(infoVC, animated: true)
    }


}
