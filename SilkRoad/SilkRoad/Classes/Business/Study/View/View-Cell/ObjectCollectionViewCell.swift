//
//  ObjectCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/29.
//

import UIKit
import SnapKit

class ObjectCollectionViewCell: UICollectionViewCell {
    
    
    override func layoutSubviews() {
        configUI()
        
    }
    
    lazy var ObjectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textColor = UIColor(red: 0.62, green: 0.478, blue: 0.353, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var ObjectIntroduceLabel: UILabel = {
        let label = UILabel()
        label.text = "文物简介文物简介文物简介文物简介"
        label.textColor = .gray
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 10)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var ObjectView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wenwu1"))
        return imageView
    }()
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    
    func configUI() {
        self.addSubview(WhiteView)
        WhiteView.addSubview(ObjectLabel)
        WhiteView.addSubview(ObjectView)
        WhiteView.addSubview(ObjectIntroduceLabel)
   
        
        WhiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.fh)
            make.right.equalToSuperview().offset(-5.fh)
            make.left.equalToSuperview().offset(5.fw)
            make.right.equalToSuperview().offset(-5.fw)
        }
        
        ObjectView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        ObjectLabel.snp.makeConstraints { make in
            make.top.equalTo(ObjectView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(15)
        }
        
        ObjectIntroduceLabel.snp.makeConstraints { make in
            make.top.equalTo(ObjectLabel.snp.bottom).offset(0)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
}
