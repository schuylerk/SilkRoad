//
//  CultureRelicHistoryView.swift
//  SilkRoad
//
//  Created by student on 2022/3/29.
//

import UIKit
import SnapKit

class CultureRelicHistoryView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#BE6B24")
        label.font = UIFont(name: "Arial", size: 18)
        label.text = "文物历史"
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#353535")
        label.font = UIFont(name: "Arial", size: 16)
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
