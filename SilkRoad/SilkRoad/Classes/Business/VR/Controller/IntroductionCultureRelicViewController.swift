//
//  IntroductionCultureRelicViewController.swift
//  SilkRoad
//
//  Created by student on 2022/3/29.
//

import UIKit
import SnapKit

protocol IntroductionCultureRelicDelegate {
    func dismissVC()
    func moveVC(_ value: CGFloat, dismiss: Bool)
    func goAnswerTheQuestion()
}

class IntroductionCultureRelicViewController: UIViewController {
    
    var model: CultureRelic!
    
    var delegate: IntroductionCultureRelicDelegate?
    
    init(_ model: CultureRelic) {
        super.init(nibName: nil, bundle: nil)
        
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var colorLayer: ColorLayer = {
        let layer = ColorLayer(
            CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.0),
            colors: [UIColor(hex: "#FFCCA3").cgColor, UIColor(hex: "#F8F8F8").cgColor],
            locations: [0, 0.5])
        layer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return layer
    }()
    
    lazy var dropDownImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "vr_dropdown")
        imgV.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        imgV.addGestureRecognizer(gesture)
        return imgV
    }()
    
    @objc func dismissVC() {
        self.delegate?.dismissVC()
    }
    
    lazy var cultureRelicImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.layer.cornerRadius = 10
        imgV.layer.masksToBounds = true
        imgV.image = UIImage(named: model.face)
        imgV.backgroundColor = .systemGray
        return imgV
    }()
    
    lazy var cultureRelicInfoView: CultureRelicInfoView = {
        let cri = CultureRelicInfoView()
        cri.model = CultureRelicInfo(
            name: model.name,
            unearthedYear: model.unearthedYear,
            unearthPlace: model.unearthPlace,
            dynasty: model.dynasty)
        return cri
    }()
    
    lazy var cultureRelicIntroView: CultureRelicIntroView = {
        let cri = CultureRelicIntroView()
        cri.contentLabel.text = model.intro
        return cri
    }()
    
    lazy var anwserButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#FFCCA3")
        button.setTitle("答题", for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(answerHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vr_collection"), for: .normal)
        button.addTarget(self, action: #selector(collectionHandler), for: .touchUpInside)
        return button
    }()
    
    @objc func answerHandler() {
        self.delegate?.goAnswerTheQuestion()
    }
    
    var collectionBack: (() -> Void)?
    
    @objc func collectionHandler() {
        collectionBack?()
        collectionButton.setImage(UIImage(named: "vr_collection_select"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        view.addGestureRecognizer(gesture)
    }
    
    var beganY: CGFloat = 0
    
    @objc func panHandler(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        if gesture.state == .began {
            beganY = location.y
        } else {
            let ty = location.y - beganY
            if gesture.state == .ended {
                self.delegate?.moveVC(ty, dismiss: true)
            } else {
                self.delegate?.moveVC(ty, dismiss: false)
            }
        }
    }
    
    func setUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(dropDownImageView)
        dropDownImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10.fw)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(50.fw)
            maker.height.equalTo(30.fh)
        }
        view.addSubview(cultureRelicImageView)
        cultureRelicImageView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(30.fw)
            maker.top.equalTo(dropDownImageView.snp.bottom).offset(10)
            maker.width.height.equalTo(170)
        }
        view.addSubview(cultureRelicInfoView)
        cultureRelicInfoView.snp.makeConstraints { maker in
            maker.left.equalTo(cultureRelicImageView.snp.right).offset(20.fw)
            maker.bottom.equalTo(cultureRelicImageView)
            maker.height.equalTo(150.fh)
            maker.right.equalToSuperview().offset(-15)
        }
        view.addSubview(cultureRelicIntroView)
        cultureRelicIntroView.snp.makeConstraints { maker in
            maker.left.equalTo(cultureRelicImageView)
            maker.top.equalTo(cultureRelicImageView.snp.bottom).offset(50.fw)
            maker.right.equalToSuperview().offset(-30.fw)
            maker.height.equalTo(150)
        }
        view.addSubview(anwserButton)
        anwserButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-50)
            maker.width.equalTo(150)
            maker.height.equalTo(34)
        }
        view.addSubview(collectionButton)
        collectionButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(30)
            maker.top.equalToSuperview().offset(10)
        }
    }
    
}
