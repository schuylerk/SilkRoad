//
//  CommodityCell.swift
//  SilkRoad
//
//  Created by student on 2022/3/28.
//

import UIKit
import SnapKit

class CommodityCell: UICollectionViewCell {
    
    var model: CommodityCellModel = CommodityCellModel() {
        didSet {
            descLabel.text = model.description
            purchasedNumLabel.text = "\(model.purchasedNum)  已购"
            priceLabel.text = "\(model.price)"
        }
    }
    
    lazy var faceImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = .systemGray6
        imgV.layer.cornerRadius = CGFloat(10.fw)
        imgV.layer.masksToBounds = true
        return imgV
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Arial", size: 16)
        label.text = model.description
        label.numberOfLines = 0
        return label
    }()
    
    lazy var purchasedNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#939393")
        label.font = UIFont(name: "Arial", size: 10)
        label.text = "\(model.purchasedNum)  已购"
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FF3A52")
        label.font = UIFont(name: "Arial", size: 25)
        label.text = "\(model.price)"
        return label
    }()
    
    func configCell(_ model: CommodityCellModel) {
        self.model = model
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(faceImageView)
        self.addSubview(descLabel)
        self.addSubview(purchasedNumLabel)
        self.addSubview(priceLabel)
        faceImageView.snp.makeConstraints { maker in
            maker.left.top.equalToSuperview().offset(15.fw)
            maker.right.equalToSuperview().offset(-15.fw)
            maker.height.equalTo(190.fh)
        }
        descLabel.snp.makeConstraints { maker in
            maker.left.right.equalTo(faceImageView)
            maker.top.equalTo(faceImageView.snp.bottom).offset(20)
        }
        purchasedNumLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(15.fw)
            maker.bottom.equalToSuperview().offset(-15.fw)
        }
        priceLabel.snp.makeConstraints { maker in
            maker.right.bottom.equalToSuperview().offset(-15.fw)
        }
    }
    
}
