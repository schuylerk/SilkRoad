//
//  OrderRemarksCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/6.
//

import UIKit
import SnapKit


class OrderRemarksCell: UITableViewCell {

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
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.systemGray.cgColor
        tv.layer.borderWidth = 0.5
        return tv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(nameLabel)
        self.addSubview(textView)
        nameLabel.snp.makeConstraints { maker in
            maker.left.top.bottom.equalToSuperview()
        }
        textView.snp.makeConstraints { maker in
            maker.right.bottom.equalToSuperview()
            maker.top.equalToSuperview().offset(20)
            maker.left.equalTo(nameLabel.snp.right).offset(40)
        }
    }

}
