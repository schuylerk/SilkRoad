//
//  CollectionRecordVerticalView.swift
//  SilkRoad
//
//  Created by student on 2022/4/2.
//

import UIKit
import SnapKit

class CollectionRecordVerticalView: UIView {

    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1),
            colors: [UIColor(hex: "#FE7D7D").cgColor, UIColor(hex: "#FFE1E2").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.4])
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        return layer
    }()
    
    lazy var titleLargeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Arial", size: 40)
        return label
    }()
    
    lazy var titleSmallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Arial", size: 16)
        label.textAlignment = .right
        return label
    }()
    
    lazy var slashView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(hex: "#FE7D7D")
        sv.transform = CGAffineTransform(rotationAngle: Double.pi/6)
        sv.layer.cornerRadius = 5
        return sv
    }()
    
    lazy var collectedNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FE7D7D")
        label.font = UIFont(name: "Arial", size: 60)
        return label
    }()
    
    lazy var collectTotalNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FE7D7D")
        label.font = UIFont(name: "Arial", size: 60)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.layer.addSublayer(colorLayer)
        self.addSubview(titleLargeLabel)
        self.addSubview(titleSmallLabel)
        self.addSubview(collectedNumLabel)
        self.addSubview(collectTotalNumLabel)
        self.addSubview(slashView)
        titleLargeLabel.snp.makeConstraints { maker in
            maker.left.top.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
        }
        titleSmallLabel.snp.makeConstraints { maker in
            maker.right.equalToSuperview().offset(-20)
            maker.top.equalTo(titleLargeLabel.snp.bottom)
        }
        collectTotalNumLabel.snp.makeConstraints { maker in
            maker.right.bottom.equalToSuperview()
        }
        slashView.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview()
            maker.height.equalTo(80)
            maker.width.equalTo(10)
            maker.right.equalTo(collectTotalNumLabel.snp.left).offset(-10)
        }
        collectedNumLabel.snp.makeConstraints { maker in
            maker.top.equalTo(slashView)
            maker.right.equalTo(slashView.snp.left).offset(-10)
        }
    }

}
