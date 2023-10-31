//
//  EditTableViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/30.
//

import UIKit

class EditTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(18.fw))
        label.textColor = .black
        return label
    }()
    
    lazy var rightView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mineRight"))
        return imageView
    }()
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "LXGW WenKai", size: CGFloat(18.fw))
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    func ConfigUI() {
        self.addSubview(titleLabel)
        self.addSubview(rightView)
        self.addSubview(answerLabel)
        
        titleLabel.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(20.fw)
            make.width.equalToSuperview().offset(-40.fw)
            make.top.bottom.equalToSuperview()
        }
        rightView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().offset(-20.fw)
            maker.width.height.equalTo(15.fw)
        }
        
        answerLabel.snp.makeConstraints {make in
            make.right.equalTo(rightView.snp.left).offset(-14.fw)
            make.width.equalTo(150.fw)
            make.top.bottom.equalToSuperview()
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnswerLabelText(type: AnswerLabelType) {
        switch type {
        case .username:
            answerLabel.text = (UserDefaults.standard.value(forKey: "username") as? String) ?? "墨笔拾丝"
        case .school:
            answerLabel.text = (UserDefaults.standard.value(forKey: "user_school") as? String) ?? "选择学校"
        }
    }

}

extension EditTableViewCell {
    
    enum AnswerLabelType {
        case username
        case school
    }
    
}
