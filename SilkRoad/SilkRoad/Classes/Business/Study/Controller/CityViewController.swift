//
//  CityViewController.swift
//  SilkRoad
//
//  Created by WSH on 2022/3/28.
//

import UIKit
import SnapKit

class CityViewController: UIViewController {
    
    let exploreCellID = "exploreCell"
    let idiomCellID = "idiomCell"
    let poetryCellID = "poertyCell"
    let questionCellID = "questionCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        // Do any additional setup after loading the view.
        
        configUI()
    }
    
    lazy var CellBackView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dunhuangback1"))
        imageView.frame = CGRect(x: 0, y: 0, width: Int(screenWidth).fw, height: 311.fh)
        return imageView
    }()

    lazy var BigNamelabel: UILabel = {
        let label = UILabel()
        label.text = "敦煌"
        label.frame = CGRect(x: 20, y: 190, width: 112, height: 73)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 50)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var IntroduceLabel: UILabel = {
        let label = UILabel()
        label.text = "地区简介地区简介地区简介地区简介地区简介地区简介"
        label.frame =  CGRect(x: 20, y: 260, width: 342, height: 44)
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
        collectionView.register(QuestionCollectionViewCell.self, forCellWithReuseIdentifier: questionCellID)
        return collectionView
    }()

    
    func configUI() {
        self.view.addSubview(CellBackView)
        self.view.addSubview(BigNamelabel)
        self.view.addSubview(IntroduceLabel)
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(320.fh)
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
    
}

extension  CityViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exploreCellID, for: indexPath) as! ExploreCollectionViewCell
            cell.cellCallBack = { () in
                let vc = IntroduceObjectViewController()
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: questionCellID, for: indexPath) as! QuestionCollectionViewCell
            cell.answerCallBack = { () in
                let vc = AnswerViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
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
        case 2:
            return CGSize(width: Int(UIScreen.main.bounds.width).fw, height: 350.fh)
        default:
            return CGSize(width: Int(UIScreen.main.bounds.width).fw, height: 100.fh)
        }
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(13.fh), right: CGFloat(0.fw))
    }
    
}
