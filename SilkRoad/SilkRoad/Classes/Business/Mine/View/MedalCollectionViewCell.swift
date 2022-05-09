//
//  MedalCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit

class MedalCollectionViewCell: UICollectionViewCell {
    
    let MedalCellID = "MedalCellIID"
    
    let name = ["西 安", "兰 州", "西 宁", "敦 煌", "乌 鲁 木 齐"]
    let goad = ["xagoad", "lzgoad", "xngoad", "dhgoad", "wlmqgoad"]
    
    override func layoutSubviews() {
        configUI()
        
    }
    
    lazy var badgelabel: UILabel = {
        let label = UILabel()
        label.text = "旅行徽章  \(4)/5"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TravelCollectionViewCell.self, forCellWithReuseIdentifier: MedalCellID)
        return collectionView
    }()
    
    
    func configUI() {
        self.addSubview(badgelabel)
        self.addSubview(collectionView)
        
        badgelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-150.fh)
            make.height.equalToSuperview().offset(10.fh)
            make.left.equalToSuperview().offset(20.fw)
            make.width.equalToSuperview().offset(20.fw)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90.fh)
            make.height.equalTo(400.fh)
            make.left.equalToSuperview().offset(10.fw)
            make.right.equalToSuperview().offset(-40.fw)
        }
    }
}

extension  MedalCollectionViewCell:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedalCellID, for: indexPath) as! TravelCollectionViewCell
        cell.namelabel.text = name[indexPath.item]
        cell.medalimageView.image = UIImage(named: goad[indexPath.item])
        return cell
    }

}
    


extension MedalCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.fw, height: 180.fh)
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(10.fw), bottom: CGFloat(50.fh), right: CGFloat(10.fw))
    }
    
}
