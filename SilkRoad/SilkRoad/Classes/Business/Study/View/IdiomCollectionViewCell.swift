//
//  IdiomCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class IdiomCollectionViewCell: UICollectionViewCell {
    
    let idiomCellID = "idiomCell"
    
    let idiomArray = ["idiom1", "idiom2", "idiom3"]
    let idiomName = ["idiom1","idiom2","idiom3"]
    
    override func layoutSubviews() {
        ConfigUI()
        
    }
    
    lazy var explabel: UILabel = {
        let label = UILabel()
        label.text = "成语世界"
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
        collectionView.frame = CGRect(x: 10, y: 30, width: screenWidth, height: 250)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceHorizontal = true
        
        collectionView.register(IdiomWordCollectionViewCell.self, forCellWithReuseIdentifier: idiomCellID)
        return collectionView
    }()
 
    func ConfigUI() {
        self.addSubview(explabel)
        self.addSubview(collectionView)
        
        
    }
    
}

extension  IdiomCollectionViewCell:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idiomCellID, for: indexPath) as! IdiomWordCollectionViewCell
        cell.rectanView.image = UIImage(named: idiomArray[indexPath.section])
        return cell
    }

}
    


extension IdiomCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.fw, height: 200.fh)
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(18.fh), right: CGFloat(10.fw))
    }
    
}
