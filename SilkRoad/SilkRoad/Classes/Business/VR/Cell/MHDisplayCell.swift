//
//  MHDisplayCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/16.
//

import UIKit

class MHDisplayCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imgv = UIImageView(frame: CGRect(x: Int(bounds.width)/2-35.fw, y:  20.fh, width: 70.fw, height: 70.fw))
        imgv.contentMode = .scaleAspectFill
        return imgv
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: Int(bounds.width)/2-100.fw, y: 30.fh+70.fw, width: 200.fw, height: 30.fh))
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
