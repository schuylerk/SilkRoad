//
//  MHDisplayCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/16.
//

import UIKit

class MHDisplayCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imgv = UIImageView(frame: CGRect(x: bounds.width/2-35, y: 20, width: 70, height: 70))
        imgv.contentMode = .scaleAspectFill
        return imgv
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: bounds.width/2-100, y: bounds.height-30, width: 200, height: 30))
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        addSubview(imageView)
        addSubview(textLabel)
    }
    
}
