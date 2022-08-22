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
    
    var cityName: String = ""
    
    var delegate: IntroductionCultureRelicDelegate?
    
    init(_ model: CultureRelic, city: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.model = model
        self.cityName = city
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
    
    @objc func dismissVC() {
        self.delegate?.dismissVC()
    }
    
    lazy var cultureRelicImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.layer.cornerRadius = 10
        imgV.layer.masksToBounds = true
        imgV.image = UIImage(named: model.face)
        imgV.contentMode = .scaleAspectFill
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.layer.addSublayer(colorLayer)
        view.addSubview(cultureRelicImageView)
        cultureRelicImageView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(30.fw)
            maker.top.equalToSuperview().offset(20.fh)
            maker.width.height.equalTo(170.fw)
        }
        view.addSubview(cultureRelicInfoView)
        cultureRelicInfoView.snp.makeConstraints { maker in
            maker.left.equalTo(cultureRelicImageView.snp.right).offset(20.fw)
            maker.bottom.equalTo(cultureRelicImageView)
            maker.height.equalTo(150.fh)
            maker.right.equalToSuperview().offset(-15.fw)
        }
        view.addSubview(cultureRelicIntroView)
        cultureRelicIntroView.snp.makeConstraints { maker in
            maker.left.equalTo(cultureRelicImageView)
            maker.top.equalTo(cultureRelicImageView.snp.bottom).offset(30.fh)
            maker.right.equalToSuperview().offset(-30.fw)
            maker.bottom.equalToSuperview()
        }
    }
    
}
