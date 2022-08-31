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
    //var setCallBack: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ConfigUI()
    }
    
    lazy var BackimageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mineback"))
        return imageView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 20.fw, y: 188.fh, width: 385.fw, height: 130.fh)
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    lazy var portraitImageView: UIImageView = {
        let image = UIImage(named: "portrait")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = CGFloat(35.fw)
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.systemGray6.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        label.text = (UserDefaults.standard.value(forKey: "username") as? String) ?? "墨笔拾丝"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var introducelabel: UILabel = {
        let label = UILabel()
        label.text = "湖南工业大学 ｜ 计算机学院"//"女｜湖南｜已解锁\(getBadge()?.count ?? 0)个旅行勋章"
        label.textColor = .gray
        label.font = UIFont.init(name: "LXGW WenKai", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
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
        
    lazy var editbutton: UIButton = {
        let button = UIButton()
        button.setTitle("编辑资料", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = CGFloat(11.fh)
        button.titleLabel?.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(12.fw))
        button.addTarget(self, action: #selector(editClick), for: .touchUpInside)
        return button
    }()
    
//    lazy var setbutton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "set"), for: .normal)
//        button.addTarget(self, action: #selector(setClick), for: .touchUpInside)
//        return button
//    }()
    
    func updateView() {
        namelabel.text = (UserDefaults.standard.value(forKey: "username") as? String) ?? "墨笔拾丝"
        var image = UIImage(named: "portrait")
        if let data = UserDefaults.standard.value(forKey: "avatar") as? Data {
            image = UIImage(data: data)
        }
        portraitImageView.image = image
    }
    
    func setPortraitImageView() {
        if let data = UserDefaults.standard.value(forKey: "avatar") as? Data {
            let image = UIImage(data: data)
            portraitImageView.image = image
        }
    }
    
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
    
//    @objc func setClick() {
//        if let callback = setCallBack {
//            callback()
//        }
//    }
    
    
    func ConfigUI() {
        contentView.addSubview(BackimageView)
        contentView.addSubview(imageView)
        contentView.addSubview(portraitImageView)
        imageView.addSubview(namelabel)
        imageView.addSubview(introducelabel)
//        imageView.addSubview(centerbutton)
        imageView.addSubview(editbutton)
    
        BackimageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(267.fh)
        }
        portraitImageView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalTo(imageView.snp.top)
            maker.width.height.equalTo(70.fw)
        }
        
        namelabel.snp.makeConstraints { make in
            make.top.equalTo(portraitImageView.snp.bottom)
            make.height.equalTo(25.fh)
            make.left.right.equalToSuperview()
        }
        
        introducelabel.snp.makeConstraints { make in
            make.top.equalTo(namelabel.snp.bottom)
            make.height.equalTo(20.fh)
            make.left.right.equalToSuperview()
        }
        
//        centerbutton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(107.fh)
//            make.height.equalTo(10.fh)
//            make.left.equalTo(portraitimageView.snp.left).offset(0.fw)
//            make.width.equalTo(80.fw)
//        }
    
        editbutton.snp.makeConstraints { make in
            make.top.equalTo(introducelabel.snp.bottom).offset(5.fh)
            make.height.equalTo(22.fh)
//            make.left.equalTo(centerbutton).offset(-10.fw)
            make.centerX.equalToSuperview()
            make.width.equalTo(80.fw)
        }
        
//        setbutton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(60.fh)
//            make.width.equalTo(50.fw)
//            make.right.equalToSuperview().offset(-25.fw)
//            make.height.equalTo(50.fh)
//        }
        
    }
}
