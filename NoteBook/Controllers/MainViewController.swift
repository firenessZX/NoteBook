//
//  ViewController.swift
//  NoteBook
//
//  Created by 云联 on 2026/5/15.
//

import UIKit
import SnapKit
class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItems()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.titleArray = DataManager.getGroupData()
        self.collectionView.reloadData()
    }
    
    func setupNavItems() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange
        appearance.titleTextAttributes = [.foregroundColor:UIColor.white,.font:UIFont.systemFont(ofSize: 18)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "点滴生活"
        let image = UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handlerAddItemAction))
    }
    
    @objc func handlerAddItemAction() {
        let alertController = UIAlertController(title: "添加记事分组", message: "添加的分组名不能与已有分组重复或为空", preferredStyle: .alert)
        alertController .addTextField()
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel))
        alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { action in
            guard let text =  alertController.textFields?.first?.text else {
                return
            }
            //进行有效性的判断
            var isExist = false
            self.viewModel.titleArray.forEach { element in
                if element == text || text.count == 0{
                    isExist = true
                }
            }
            
            if isExist {
                return
            }
            
            DataManager.saveGroup(name: text)
            self.collectionView.performBatchUpdates {
                let indexPath = IndexPath(item: self.viewModel.titleArray.count, section: 0)
                self.collectionView.insertItems(at: [indexPath])
                self.viewModel.titleArray.append(text)
            }
            
            
        }))
        self.present(alertController, animated: true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainCell = collectionView .dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseID, for: indexPath) as! MainCollectionViewCell
        mainCell.titleLabel.text = self.viewModel.titleArray[indexPath.item]
        return mainCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title  = self.viewModel.titleArray[indexPath.item]
        let noteListVC = NoteListTableViewController()
        noteListVC.groupName = title
        self.navigationController?.pushViewController(noteListVC, animated: true)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        layout.minimumInteritemSpacing = 15
        layout.itemSize = CGSize(width: (self.view.frame.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing * 2)/3.0, height: 120);
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseID)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self;
        collectionView.delegate = self;
        return collectionView
    }()

}

