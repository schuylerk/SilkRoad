//
//  CityViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit
import SnapKit

class CityViewController: UIViewController {
    
    var intro = CityIntroduce()
    var relic = CultureRelic()
    let exploreCellID = "exploreCell"
    let idiomCellID = "idiomCell"
    let poetryCellID = "poertyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: Int(screenWidth), height: 311.fh)
        return view
    }()
    
    lazy var cellBackView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lanzhouback"))
        imageView.image = UIImage(named: "dunhuangback")
        imageView.frame = CGRect(x: 0, y: 0, width: Int(screenWidth), height: 311.fh)
        imageView.backgroundColor = .systemGray6
        return imageView
    }()

    lazy var bigNamelabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20.fw, y: 190.fh, width: 200.fw, height: 73.fh)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(50.fw))
        label.numberOfLines = 0
        return label
    }()
    
    lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: CGFloat(15.fw))
        label.numberOfLines = 0
        return label
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back.white"), for: .normal)
        button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fw)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .allEvents)
        return button
    }()
    
    lazy var answerButton: UIButton = {
        let button = UIButton()
        let isCompleteAnswer = (getBadge() ?? []).firstIndex(where: { $0==intro.name }) != nil
        button.backgroundColor = .orange
        button.setTitle(isCompleteAnswer ? "查看题目（已完成）" : "答题", for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat(isCompleteAnswer ? 12.fw : 16.fw))
        button.layer.cornerRadius = CGFloat(20.fh)
        button.addTarget(self, action: #selector(answerHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var goadImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.image = UIImage(named: getGoadName())
        let isCompleteAnswer = (getBadge() ?? []).firstIndex(where: { $0==intro.name }) != nil
        imgv.isHidden = !isCompleteAnswer
        return imgv
    }()
    
    func getGoadName() -> String {
        switch intro.name {
        case "西安":
            return "xagoad"
        case "兰州":
            return "lzgoad"
        case "乌鲁木齐":
            return "wlmqgoad"
        case "西宁":
            return "xngoad"
        case "敦煌":
            return "dhgoad"
        default:
            return ""
        }
    }
    
    @objc func clickLeftBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var gradientLayer: CAGradientLayer = {
        let galayer = CAGradientLayer()
        galayer.frame = backView.bounds
        let aCLolor = UIColor.blue.cgColor
        let bColor = UIColor.brown.cgColor
        let cColor = UIColor.red.cgColor
        galayer.colors = [aCLolor,bColor, cColor]
        galayer.startPoint = CGPoint(x: 0, y: 0)
        galayer.endPoint = CGPoint(x: 1, y: 1)
        galayer.locations = [0, 0.3, 1]
        return galayer
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: exploreCellID)
        collectionView.register(IdiomCollectionViewCell.self, forCellWithReuseIdentifier: idiomCellID)
        collectionView.register(PoetryCollectionViewCell.self, forCellWithReuseIdentifier: poetryCellID)
        return collectionView
    }()
    
    lazy var ipView: IPView = {
        let ipv = IPView(frame: CGRect(x: 80.fw, y: Int(screenHeight)/2-30.fh, width: Int(screenWidth)-60.fw, height: 60.fh))
        ipv.textPosition = .left
        ipv.text = "答题可以获得思绸勋章哦！"
        ipv.isHidden = true
        return ipv
    }()
    
    lazy var blackButton: UIButton = {
        let button = UIButton(frame: view.bounds)
        button.backgroundColor = .black
        button.alpha = 0.7
        button.addTarget(self, action: #selector(tapBlackButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc func tapBlackButton() {
        ipView.isHidden = true
        blackButton.isHidden = true
    }

    
    func configUI() {
        view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        view.addSubview(backView)
        view.addSubview(cellBackView)
        view.addSubview(bigNamelabel)
        view.addSubview(goadImageView)
        view.addSubview(answerButton)
        view.addSubview(introduceLabel)
        view.addSubview(collectionView)
        view.addSubview(leftButton)
        view.addSubview(blackButton)
        view.addSubview(ipView)
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(bigNamelabel.snp.bottom)
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
        }
        answerButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(300.fw)
            maker.top.equalTo(introduceLabel.snp.bottom).offset(15.fh)
            maker.height.equalTo(40.fh)
        }
        goadImageView.snp.makeConstraints { maker in
            maker.centerY.equalTo(answerButton)
            maker.width.height.equalTo(30.fw)
            maker.left.equalToSuperview().offset(20.fw)
        }
        collectionView.snp.makeConstraints {make in
            make.top.equalTo(answerButton.snp.bottom).offset(5.fh)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isCompleteAnswer = (getBadge() ?? []).firstIndex(where: { $0==intro.name }) != nil
        answerButton.backgroundColor = .orange
        answerButton.setTitle(isCompleteAnswer ? "查看题目（已完成）" : "答题", for: .normal)
        answerButton.titleLabel?.font = .systemFont(ofSize: CGFloat(isCompleteAnswer ? 12.fw : 16.fw))
        goadImageView.isHidden = !isCompleteAnswer
        
        let firstEnterCityVC = (UserDefaults.standard.value(forKey: "firstentercityvc") as? Bool) ?? true
        if firstEnterCityVC {
            blackButton.isHidden = false
            ipView.isHidden = false
            ipView.display()
            ipView.animateImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/6)
            UserDefaults.standard.set(false, forKey: "firstentercityvc")
        }
    }
    
    func updateUI(with data: CityIntroduce){
        self.intro = data
        self.cellBackView.image = UIImage(named: data.back)
        self.bigNamelabel.text = data.name
        self.introduceLabel.text = data.introduce
    }
    
}

extension  CityViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exploreCellID, for: indexPath) as! ExploreCollectionViewCell
            cell.handyJSON(self.intro.name)
            print(self.intro.name)
            cell.cellCallBack = { data, face in
                let vc = IntroduceObjectViewController()
                vc.updateUI(data: data)
                vc.faceImageView.image = UIImage(named: face)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idiomCellID, for: indexPath) as! IdiomCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poetryCellID, for: indexPath) as! PoetryCollectionViewCell
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }

}
    


extension CityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section{
        case 0:
            return CGSize(width: Int(UIScreen.main.bounds.width), height: 350.fh)
        case 1:
            return CGSize(width: Int(UIScreen.main.bounds.width), height: 240.fh)
        case 2:
            return CGSize(width: Int(UIScreen.main.bounds.width), height: 350.fh)
        default:
            return .zero
        }
    }
    
}

extension CityViewController {
    
    @objc func answerHandler() {
        let isCompleteAnswer = (getBadge() ?? []).firstIndex(where: { $0==intro.name }) != nil
        let vc = AnswerViewController()
        vc.cityName = intro.name
        vc.isCompleteAnswer = isCompleteAnswer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
