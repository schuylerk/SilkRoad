//
//  UnitPriceCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/6.
//

import UIKit
import SnapKit

class UnitPriceCell: UITableViewCell {

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
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 14)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(nameLabel)
        self.addSubview(valueLabel)
        nameLabel.snp.makeConstraints { maker in
            maker.left.top.bottom.equalToSuperview()
        }
        valueLabel.snp.makeConstraints { maker in
            maker.top.right.bottom.equalToSuperview()
        }
    }

}
