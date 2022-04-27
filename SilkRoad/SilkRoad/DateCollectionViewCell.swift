//
//  DateCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/22.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
    }
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        layerView.layer.shadowOpacity = 1
        //layerView.backgroundColor = .clear
        layerView.layer.cornerRadius = 5
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var DayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
 
    func configUI(){
        self.addSubview(WhiteView)
        WhiteView.addSubview(DayLabel)
        
        WhiteView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        
        DayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.fh)
            make.left.equalToSuperview().offset(0.fw)
            make.right.equalToSuperview().offset(0.fw)
            make.height.equalTo(45)
        }
        
    }
}
