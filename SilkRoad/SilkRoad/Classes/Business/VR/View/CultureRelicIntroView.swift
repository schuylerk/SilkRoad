//
//  CultureRelicIntroView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/9.
//

import UIKit

class CultureRelicIntroView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#BE6B24")
        label.font = UIFont(name: "Arial", size: 20)
        label.text = "简介"
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#353535")
        label.font = UIFont(name: "Arial", size: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.left.top.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }

}
