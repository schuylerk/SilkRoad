//
//  QuestionCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/31.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    var answerCallBack: (() -> Void)?
    
    
    override func layoutSubviews() {
        ConfigUI()
        
    }
    
    lazy var answerbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "question"), for: .normal)
        button.addTarget(self, action: #selector(answerClick), for: .touchUpInside)
        return button
    }()
    
    @objc func answerClick() {
        if let callback = answerCallBack {
            callback()
        }
    }
    
    func ConfigUI() {
        self.addSubview(answerbutton)
        
        answerbutton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            
        }
    }
    
}
