//
//  SettwoTableViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/30.
//

import UIKit

class SettwoTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "退出账号"
        label.textColor = UIColor(red: 1, green: 0.333, blue: 0.333, alpha: 1)
        return label
    }()
    
    
    func ConfigUI() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(170.fw)
            make.width.equalToSuperview().offset(50.fw)
            make.top.equalToSuperview().offset(0.fh)
            make.bottom.equalToSuperview().offset(5.fh)
        }
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
