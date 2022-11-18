//
//  PoetryCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class PoetryCollectionViewCell: UICollectionViewCell {
    
    let PotCellID = "PotCell"
    let poemName = ["poem1","poem2","poem3"]
    
    override func layoutSubviews() {
        ConfigUI()
        
    }
    
    lazy var explabel: UILabel = {
        let label = UILabel()
        label.text = "诗湖辞海"
        label.frame = CGRect(x: 20.fw, y: 5.fh, width: 100.fw, height: 50.fh)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(20.fw))
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 20.fw, y: 55.fh, width: Int(screenWidth)-40.fw, height: 280.fh)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(PoemCollectionViewCell.self, forCellWithReuseIdentifier: PotCellID)
        return collectionView
    }()
    
    func ConfigUI() {
        self.addSubview(explabel)
        self.addSubview(collectionView)
    }
    
}

extension  PoetryCollectionViewCell:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PotCellID, for: indexPath) as! PoemCollectionViewCell
        cell.rectanView.image = UIImage(named: poemName[indexPath.section])
        return cell
    }

}
    


extension PoetryCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.fw, height: 280.fh)
    }
    
}
