//
//  GameCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/5/8.
//

import UIKit
import SnapKit

class GameCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imgv = UIImageView()
        return imgv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var introLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(imageView)
        self.addSubview(nameLabel)
        self.addSubview(introLabel)
        imageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview().offset(-20)
            maker.left.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-20)
        }
        introLabel.snp.makeConstraints { maker in
            maker.left.equalTo(imageView.snp.right).offset(10)
            maker.centerY.equalTo(imageView)
            maker.right.equalToSuperview().offset(-20)
        }
    }
    
}
