//
//  PurchaseQuantityCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/6.
//

import UIKit
import SnapKit

class PurchaseQuantityCell: UITableViewCell {

    typealias CallBack = ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Arial", size: 14)
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        return button
    }()
    
    lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.addTarget(self, action: #selector(decrease), for: .touchUpInside)
        return button
    }()
    
    @objc func add() {
        let value = (Int(valueLabel.text ?? "0") ?? 0) + 1
        valueLabel.text = "\(value)"
        NotificationCenter.default.post(name: .init("updateSubmitLabel"), object: nil, userInfo: ["count":value])
    }
    
    @objc func decrease() {
        var value = (Int(valueLabel.text ?? "0") ?? 0) - 1
        value = value >= 0 ? value : 0
        valueLabel.text = "\(value)"
        NotificationCenter.default.post(name: .init("updateSubmitLabel"), object: nil, userInfo: ["count":value])
    }
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.systemGray.cgColor
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(nameLabel)
        self.addSubview(decreaseButton)
        self.addSubview(valueLabel)
        self.addSubview(addButton)
        nameLabel.snp.makeConstraints { maker in
            maker.left.top.bottom.equalToSuperview()
        }
        addButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview()
            maker.width.equalTo(30)
            maker.height.equalTo(20)
        }
        valueLabel.snp.makeConstraints { maker in
            maker.centerY.top.bottom.width.equalTo(addButton)
            maker.right.equalTo(addButton.snp.left)
        }
        decreaseButton.snp.makeConstraints { maker in
            maker.top.bottom.centerY.width.equalTo(addButton)
            maker.right.equalTo(valueLabel.snp.left)
        }
    }

}
