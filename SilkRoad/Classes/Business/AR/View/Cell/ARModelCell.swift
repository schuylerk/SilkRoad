//
//  ARModelCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/30.
//

import UIKit

class ARModelCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imgv = UIImageView()
        imgv.layer.cornerRadius = 10
        imgv.layer.masksToBounds = true
        return imgv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.height.equalTo(80)
        }
    }
    
}
