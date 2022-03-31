//
//  ExploreCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    
    var cellCallBack: (() -> Void)?
    
    let ObjectCellID = "ObjectCell"
    
    let ObjectName = ["文物名称1", "文物名称2", "文物名称3"]
    
    override func layoutSubviews() {
        ConfigUI()
        
    }
    
    lazy var explabel: UILabel = {
        let label = UILabel()
        label.text = "文物探索"
        label.frame = CGRect(x: 20, y: 5, width: 100, height: 50)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 20, y: 45, width: screenWidth, height: 280)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceHorizontal = true
        
        collectionView.register(ObjectCollectionViewCell.self, forCellWithReuseIdentifier: ObjectCellID)
        return collectionView
    }()
    
    func ConfigUI() {
        self.addSubview(explabel)
        self.addSubview(collectionView)
        
    }
    
}

extension  ExploreCollectionViewCell:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ObjectCellID, for: indexPath) as! ObjectCollectionViewCell
        cell.ObjectLabel.text = ObjectName[indexPath.section]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = cellCallBack {
            callback()
        }
        
    }
}
    


extension ExploreCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.fw, height: 250.fh)
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(13.fh), right: CGFloat(20.fw))
    }
    
}
