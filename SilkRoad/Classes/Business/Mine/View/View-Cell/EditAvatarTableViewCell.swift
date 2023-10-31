//
//  EditAvatarTableViewCell.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/8/18.
//

import UIKit
import SnapKit

class EditAvatarTableViewCell: EditTableViewCell {
    
    lazy var avatarImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.backgroundColor = .gray
        imgv.layer.cornerRadius = CGFloat(20.fw)
        imgv.layer.masksToBounds = true
        return imgv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func ConfigUI() {
        super.ConfigUI()
        answerLabel.isHidden = true
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().offset(-50.fw)
            maker.width.height.equalTo(40.fw)
        }
    }
    
    func updateImage(with image: UIImage) {
        avatarImageView.image = image
    }
    
    func setAvataImage() {
        if let data = UserDefaults.standard.value(forKey: "avatar") as? Data {
            avatarImageView.image = UIImage(data: data)
        } else {
            avatarImageView.image = UIImage(named: "portrait")
        }
    }
    
}
