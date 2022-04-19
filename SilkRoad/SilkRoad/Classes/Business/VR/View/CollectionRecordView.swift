//
//  CollectionRecordView.swift
//  SilkRoad
//
//  Created by student on 2022/4/2.
//

import UIKit
import SnapKit

class CollectionRecordView: UIView {

    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0, y: 0.5),
            endPoint: CGPoint(x: 1, y: 0.5),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.8])
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        return layer
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }()
    
    lazy var slashView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(hex: "#FFCCA3")
        sv.transform = CGAffineTransform(rotationAngle: Double.pi/6)
        sv.layer.cornerRadius = 5
        return sv
    }()
    
    lazy var collectedNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FFCCA3")
        label.font = UIFont(name: "Arial", size: 60)
        return label
    }()
    
    lazy var collectTotalNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FFCCA3")
        label.font = UIFont(name: "Arial", size: 60)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.layer.addSublayer(colorLayer)
        self.addSubview(titleLabel)
        self.addSubview(collectedNumLabel)
        self.addSubview(slashView)
        self.addSubview(collectTotalNumLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(15)
            maker.bottom.equalToSuperview().offset(-20)
        }
        collectTotalNumLabel.snp.makeConstraints { maker in
            maker.right.bottom.equalToSuperview()
        }
        slashView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
            maker.width.equalTo(10)
            maker.right.equalTo(collectTotalNumLabel.snp.left).offset(-10)
        }
        collectedNumLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.right.equalTo(slashView.snp.left)
        }
    }

}
