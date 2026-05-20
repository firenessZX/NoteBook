//
//  MainCollectionViewCell.swift
//  NoteBook
//
//  Created by 云联 on 2026/5/18.
//

import UIKit
import SnapKit
class MainCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .orange.withAlphaComponent(0.2)
        self.contentView.layer.cornerRadius = 8.0;
        self.contentView.layer.masksToBounds = true
        self.contentView .addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

extension UICollectionViewCell {
    class var reuseID: String {
         get {
             return NSStringFromClass(self)
         }
    }
}

extension UITableViewCell {
    class var reuseID: String {
         get {
             return NSStringFromClass(self)
         }
    }
}
