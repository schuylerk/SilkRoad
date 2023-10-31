//
//  ARModelListView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/30.
//

import UIKit

class ARModelListView: UIView {
    
    var models: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var tapSelectHandler: ((IndexPath) -> Void)?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 80, height: 80)
        let clv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.register(ARModelCell.self, forCellWithReuseIdentifier: "armodel")
        return clv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(15)
            maker.left.equalToSuperview().offset(15)
            maker.bottom.right.equalToSuperview().offset(-15)
        }
    }

}

extension ARModelListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "armodel", for: indexPath) as! ARModelCell
        cell.imageView.image = models[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tapSelectHandler?(indexPath)
    }
    
}
