//
//  CultureRelicInfoView.swift
//  SilkRoad
//
//  Created by student on 2022/3/29.
//

import UIKit
import SnapKit

class CultureRelicInfoView: UIView {
    
    var model: CultureRelicInfo = CultureRelicInfo() {
        didSet {
            nameLabel.text = model.name
            unearthedYearLabel.text = "出土年份:  未知"// \(model.unearthedYear)"
            unearthedPlaceLabel.text = "出土地点:  未知"// \(model.unearthPlace)"
            dynastyLabel.text = "所属朝代:   \(model.dynasty)"
        }
    }

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Arial", size: 20)
        label.text = model.name
        label.numberOfLines = 0
        return label
    }()
    
    lazy var unearthedYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#494949")
        label.font = UIFont(name: "Arial", size: 16)
        label.text = "出土年份: \(model.unearthedYear)"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var unearthedPlaceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#494949")
        label.font = UIFont(name: "Arial", size: 16)
        label.text = "出土地点: \(model.unearthPlace)"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dynastyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#494949")
        label.font = UIFont(name: "Arial", size: 16)
        label.text = "所属朝代: \(model.dynasty)"
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(nameLabel)
        self.addSubview(unearthedYearLabel)
        self.addSubview(unearthedPlaceLabel)
        self.addSubview(dynastyLabel)
        dynastyLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        unearthedPlaceLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(dynastyLabel.snp.top).offset(-10.fh)
        }
        unearthedYearLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(unearthedPlaceLabel.snp.top).offset(-10.fh)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(unearthedYearLabel.snp.top).offset(-20.fh)
        }
    }

}
