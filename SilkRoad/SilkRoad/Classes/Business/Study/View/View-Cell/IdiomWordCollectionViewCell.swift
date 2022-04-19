//
//  IdiomWordCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class IdiomWordCollectionViewCell: UICollectionViewCell {
    
    
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
            make.top.equalToSuperview().offset(0.fh)
            make.bottom.equalToSuperview().offset(0.fh)
            make.left.equalToSuperview().offset(0.fw)
            make.right.equalToSuperview().offset(0.fw)
        }
        
    }
    
    
}
