//
//  TravelCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit

class TravelCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        ConfigUI()
        
    }
 
    lazy var medalimageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
 
    lazy var namelabel: UILabel = {
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

    func ConfigUI() {
        self.addSubview(medalimageView)
        self.addSubview(namelabel)
//        self.addSubview(datelabel)
        
        medalimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.fh)
            make.width.height.equalTo(120.fw)
            make.centerX.equalToSuperview()
        }
        
        namelabel.snp.makeConstraints { make in
            make.top.equalTo(medalimageView.snp.bottom).offset(10.fh)
            make.left.bottom.right.equalToSuperview()
        }
        
//        datelabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(95.fh)
//            make.left.equalToSuperview().offset(0.fw)
//            make.height.equalToSuperview().offset(5.fh)
//            make.width.equalToSuperview().offset(10.fw)
//        }
    }
}
