//
//  MineDataCollectionViewCell.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit
import SnapKit

class MineDataCollectionViewCell: UICollectionViewCell {
    
    var searchCallBack: (() -> Void)?
    var editCallBack: (() -> Void)?
    var setCallBack: (() -> Void)?
    
    override func layoutSubviews() {
        ConfigUI()
        
    }
    
    lazy var BackimageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mineback"))
        imageView.frame = CGRect(x: 0.fw, y: -100.fh, width: Int(UIScreen.main.bounds.width).fw , height: 269.fh)
        return imageView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 20, y: 115, width: 385, height: 180)
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    lazy var portraitimageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "portrait"))
        imageView.frame = CGRect(x: (Int(screenWidth)/2 - 35).fw, y: 85.fh, width: 70.fw, height: 70.fh)
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        label.text = "小王子"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var introducelabel: UILabel = {
        let label = UILabel()
        label.text = "女｜湖南｜已解锁\(4)个旅行勋章"
        label.textColor = .gray
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var centerbutton: UIButton = {
        let button = UIButton()
        button.setTitle("积分中心 >", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        button.addTarget(self, action: #selector(searchBarClick), for: .touchUpInside)
        return button
    }()
    
    lazy var editimageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "edit"))
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 150, y: 133, width: 78, height: 24)
        imageView.clipsToBounds = true
        return imageView
    }()
        
    lazy var editbutton: UIButton = {
        let button = UIButton()
        button.setTitle("编辑资料", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 12)
        button.addTarget(self, action: #selector(editClick), for: .touchUpInside)
        return button
    }()
    
    lazy var setbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "set"), for: .normal)
        button.addTarget(self, action: #selector(setClick), for: .touchUpInside)
        return button
    }()
    
    @objc func searchBarClick() {
        if let callback = searchCallBack {
            callback()
        }
    }
    
    @objc func editClick () {
        if let callback = editCallBack {
            callback()
        }
    }
    
    @objc func setClick() {
        if let callback = setCallBack {
            callback()
        }
    }
    
    
    func ConfigUI() {
        contentView.addSubview(BackimageView)
        contentView.addSubview(imageView)
        contentView.addSubview(setbutton)
        self.addSubview(portraitimageView)
        imageView.addSubview(editimageView)
        imageView.addSubview(namelabel)
        imageView.addSubview(introducelabel)
        imageView.addSubview(centerbutton)
        imageView.addSubview(editbutton)
    
        
        namelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-40.fh)
            make.height.equalToSuperview().offset(10.fh)
            make.left.equalTo(portraitimageView.snp.left).offset(10.fw)
            make.width.equalToSuperview().offset(10.fw)
        }
        
        introducelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-15.fh)
            make.height.equalToSuperview().offset(10.fh)
            make.left.equalToSuperview().offset(Int(screenWidth/2-120).fw)
            make.width.equalToSuperview().offset(100.fw)
        }
        
        centerbutton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(107.fh)
            make.height.equalTo(10.fh)
            make.left.equalTo(portraitimageView.snp.left).offset(0.fw)
            make.width.equalTo(80.fw)
        }
    
        editbutton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(137.fh)
            make.height.equalTo(15.fh)
            make.left.equalTo(centerbutton).offset(-10)
            make.width.equalTo(80)
        }
        
        setbutton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-10.fh)
            make.width.equalTo(40)
            make.right.equalToSuperview().offset(-30.fw)
            make.height.equalTo(40)
        }
        
    }
}
