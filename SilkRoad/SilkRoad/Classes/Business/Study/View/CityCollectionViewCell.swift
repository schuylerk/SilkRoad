//
//  CityCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit
import SnapKit

class CityCollectionView: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
//        self.backgroundColor = .white
    }
    
    
    lazy var Studylabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(40.fw))
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var BackView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CGFloat(20.fw)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    func configUI() {
        self.addSubview(BackView)
        self.addSubview(Studylabel)
        
        Studylabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17.fh)
            make.height.equalToSuperview().offset(28.fh)
            make.left.equalToSuperview().offset(10.fw)
            make.width.equalToSuperview().offset(50.fw)
        }
        
        BackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.fh)
            make.bottom.equalToSuperview().offset(-20.fh)
            make.left.equalToSuperview().offset(0.fw)
            make.right.equalToSuperview().offset(0.fw)
        }
    }
    
}
