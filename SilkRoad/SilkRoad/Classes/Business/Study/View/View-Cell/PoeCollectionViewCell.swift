//
//  PoeCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit

class PoeCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        //configUI()
        
    }
    
    lazy var rectanView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
}
