//
//  CultureRelicDialogueView.swift
//  SilkRoad
//
//  Created by 康思为 on 2022/4/19.
//

import UIKit
import SnapKit

class CultureRelicDialogueView: UIView {
    
    var backgroundViewColor: UIColor?
    var faceImage: UIImage?
    var contents: [String]?
    var actionImage: UIImage?
    private var currentContentIndex: Int = 0 {
        didSet {
            contentLabel.text = contents?[currentContentIndex]
        }
    }

    lazy var backgroundView: UIView = {
        let bgv = UIView()
        bgv.backgroundColor = backgroundViewColor
        return bgv
    }()
    
    lazy var faceImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = faceImage
        imgV.layer.masksToBounds = true
        imgV.layer.cornerRadius = 15
        return imgV
    }()
    
    lazy var contentsView: UIView = {
        let ctv = UIView()
        ctv.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { maker in
            maker.left.top.equalToSuperview().offset(10)
            maker.right.bottom.equalToSuperview().offset(-10)
        }
        return ctv
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = contents?[currentContentIndex]
        label.numberOfLines = 0
        return label
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setImage(actionImage, for: .normal)
        button.addTarget(self, action: #selector(actionHandle), for: .touchUpInside)
        return button
    }()
    
    @objc func actionHandle() {
        currentContentIndex = currentContentIndex+1 >= contents!.count-1 ? contents!.count-1 : currentContentIndex+1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(backgroundView)
        self.addSubview(faceImageView)
        self.addSubview(contentsView)
        self.addSubview(actionButton)
        backgroundView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        faceImageView.snp.makeConstraints { maker in
            maker.left.top.equalTo(backgroundView).offset(15)
            maker.width.height.equalTo(30)
        }
        contentsView.snp.makeConstraints { maker in
            maker.top.equalTo(faceImageView)
            maker.left.equalTo(faceImageView.snp.right).offset(20)
            maker.right.bottom.equalTo(backgroundView).offset(-20)
        }
        actionButton.snp.makeConstraints { maker in
            maker.right.bottom.equalTo(backgroundView).offset(-20)
        }
    }
    
}
