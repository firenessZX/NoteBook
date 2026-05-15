//
//  ViewController.swift
//  NoteBook
//
//  Created by 云联 on 2026/5/15.
//

import UIKit
import SnapKit
class MainViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItems()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
            print(text)
        }))
        self.present(alertController, animated: true)
    }
    

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
         collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        return collectionView
    }()

}

