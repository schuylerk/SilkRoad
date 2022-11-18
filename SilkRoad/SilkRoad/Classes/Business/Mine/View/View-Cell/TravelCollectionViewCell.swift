//
//  TravelCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit
import SnapKit

class TravelCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
 
    lazy var medalImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
 
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var datelabel: UILabel = {
        let label = UILabel()
        label.text = "2022.3.17"
        label.textAlignment = .center
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 10)
        label.numberOfLines = 0
        return label
    }()

    func configUI() {
        addSubview(medalImageView)
        addSubview(nameLabel)
        medalImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.fh)
            make.width.height.equalTo(120.fw)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(medalImageView.snp.bottom).offset(10.fh)
            make.centerX.equalToSuperview()
        }
    }
}
