//
//  CityViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit
import SnapKit

class CityViewController: UIViewController {
    
    var intro = Introduce()
    var relic = CultureRelic()
    
    let exploreCellID = "exploreCell"
    let idiomCellID = "idiomCell"
    let poetryCellID = "poertyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        configUI()
    }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: Int(screenWidth).fw, height: 311.fh)
        return view
    }()
    
    lazy var CellBackView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lanzhouback"))
        imageView.image = UIImage(named: "dunhuangback")
        imageView.frame = CGRect(x: 0, y: 0, width: Int(screenWidth).fw, height: 311.fh)
        return imageView
    }()

    lazy var BigNamelabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 190, width: 200, height: 73)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 50)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var IntroduceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var answerbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "answer"), for: .normal)
        return button
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fh)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .allEvents)
        
        return button
    }()
    
    @objc func clickLeftBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var gradientLayer: CAGradientLayer = {
        let galayer = CAGradientLayer()
        galayer.frame = backView.bounds
        print(galayer.frame)
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
        //collectionView.register(QuestionCollectionViewCell.self, forCellWithReuseIdentifier: questionCellID)
        return collectionView
    }()

    
    func configUI() {
        self.view.addSubview(backView)
        self.view.addSubview(CellBackView)
        self.view.addSubview(BigNamelabel)
        self.view.addSubview(IntroduceLabel)
        self.view.addSubview(collectionView)
        self.view.addSubview(leftButton)
        
        IntroduceLabel.snp.makeConstraints { make in
            make.top.equalTo(BigNamelabel.snp.bottom).offset(0)
            make.height.equalTo(65)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        
        collectionView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(328.fh)
            make.left.equalToSuperview().offset(0.fw)
            make.height.equalTo(600)
            make.width.equalTo(Int(screenWidth).fw)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func updateUI(with data:Introduce){
        self.intro = data
        self.CellBackView.image = UIImage(named: data.back)
        self.BigNamelabel.text = data.name
        self.IntroduceLabel.text = data.introduce
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
                print(data.unearthedYear)
                vc.BackView.image = UIImage(named: face)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idiomCellID, for: indexPath) as! IdiomCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poetryCellID, for: indexPath) as! PoetryCollectionViewCell
            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: questionCellID, for: indexPath) as! QuestionCollectionViewCell
//            cell.answerCallBack = { () in
//                let vc = AnswerViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            return cell
        }
        
    }

}
    


extension CityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section{
        case 0:
            return CGSize(width: Int(UIScreen.main.bounds.width).fw, height: 300.fh)
        case 1:
            return CGSize(width: Int(UIScreen.main.bounds.width).fw, height: 210.fh)
        default:
            return CGSize(width: Int(UIScreen.main.bounds.width).fw, height: 350.fh)
//        default:
//            return CGSize(width: Int(UIScreen.main.bounds.width).fw, height: 100.fh)
        }
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(13.fh), right: CGFloat(0.fw))
    }
    
}
