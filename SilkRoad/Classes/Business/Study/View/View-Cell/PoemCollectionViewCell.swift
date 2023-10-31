//
//  PoemCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class PoemCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        ConfigUI()
        
    }
    
    lazy var rectanView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    func ConfigUI() {
        self.addSubview(rectanView)
        
        rectanView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
