//
//  ReceiveAddressCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/6.
//

import UIKit
import SnapKit

class ReceiveAddressCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FFAD80")
        label.font = UIFont(name: "Arial", size: 18)
        return label
    }()
    
    lazy var addresseeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Arial", size: 18)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Arial", size: 14)
        return label
    }()
    
    lazy var telephoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Arial", size: 18)
        return label
    }()
    
    lazy var verticalDivider: UIView = {
        let vi = UIView()
        vi.backgroundColor = .systemGray3
        return vi
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(titleLabel)
        self.addSubview(verticalDivider)
        self.addSubview(addresseeLabel)
        self.addSubview(telephoneNumberLabel)
        self.addSubview(addressLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(20)
        }
        verticalDivider.snp.makeConstraints { maker in
            maker.left.equalTo(titleLabel.snp.right).offset(20)
            maker.top.bottom.equalToSuperview()
            maker.width.equalTo(1)
        }
        addresseeLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(20)
            maker.left.equalTo(verticalDivider.snp.right).offset(10)
        }
        telephoneNumberLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
        }
        addressLabel.snp.makeConstraints { maker in
            maker.left.equalTo(addresseeLabel)
            maker.top.equalTo(addresseeLabel.snp.bottom).offset(30)
        }
    }
    
}
